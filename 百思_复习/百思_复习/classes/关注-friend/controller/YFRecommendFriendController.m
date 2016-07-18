//
//  YFRecommendFriendController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/16.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFRecommendFriendController.h"
#import <AFNetworking.h>
#import "YFCategory.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "YFCategoryCell.h"
#import "YFUser.h"
#import "YFUserCell.h"

#define YFSelectCategory self.categories[[self.categoryTableView indexPathForSelectedRow].row]
@interface YFRecommendFriendController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 分类数组 */
@property(nonatomic,strong)NSArray *categories;


/** 用户数组 */
@property(nonatomic,strong)NSMutableArray *users;

/** nextPage */
@property(nonatomic,assign)int page;
/** 请求的参数 */
@property(nonatomic,strong)NSDictionary *params;
@end

@implementation YFRecommendFriendController

static NSString *const XMGCategoryID = @"category";
static NSString *const XMGUserID = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YFCategoryCell class]) bundle:nil] forCellReuseIdentifier:XMGCategoryID];
    
    [self setupRequest];
    
    //刷新界面
    [self setupRefresh];
    
    self.userTableView.estimatedRowHeight = 200;
    
    
}
-(void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    
}
-(void)loadMoreUsers
{
    YFCategory *rc = self.categories[[self.categoryTableView indexPathForSelectedRow].row ];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id) ;
    params[@"page"] = @(self.page+1);
    
    self.params = params;
    
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
            
            if(params != self.params) {
                return ;
            }
            self.page++;
            NSArray *users = [YFUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            rc.total = [responseObject[@"total"] integerValue];
            [rc.users addObjectsFromArray:users];
            
            [self.userTableView reloadData];
            
            [self checkStates];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
   
    
    
}
-(void)loadNewUsers
{
    YFCategory *rc = YFSelectCategory;
  
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id) ;
    
    self.params = params;
    
   
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
            
            if(params != self.params) return ;
            
            [rc.users removeAllObjects];
            NSArray *users = [YFUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [rc.users addObjectsFromArray:users] ;
            
            self.page = 1;
            
            [self.userTableView reloadData];
            rc.total = [responseObject[@"total"] integerValue];
            
            [self checkStates];
            
            [self.userTableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
   
    
    
}
-(void)checkStates
{
    YFCategory *category = YFSelectCategory;
    self.userTableView.mj_footer.hidden = category.users.count==0;
    if(category.users.count>= category.total){
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self.userTableView.mj_footer endRefreshing];
    }
}
//发送请求
-(void)setupRequest
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] =  @"category";
    params[@"c"] = @"subscribe";
    
         [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            
            self.categories = [YFCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            [self.categoryTableView reloadData];
            
            [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.userTableView.mj_header beginRefreshing];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"骑牛失败");
        }];
    
    
    
    
}

-(void)dealloc
{
    [[AFHTTPSessionManager manager].operationQueue cancelAllOperations];
}

#pragma mark - <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.userTableView){
        YFCategory *category = YFSelectCategory;
        
        [self checkStates];
        return category.users.count;
    }else{
        return self.categories.count;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.categoryTableView){
        
        YFCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCategoryID];
        
        YFCategory *category = self.categories[indexPath.row];
        
        cell.category = category;
        
        
        
        return cell;
    }else
    {
        
        YFCategory *category = YFSelectCategory;
        YFUserCell *cell =  [YFUserCell cellWithTableView:tableView];
        cell.user = category.users[indexPath.row];
        
        return cell;
        
        
    }
    
    
    
}

#pragma mark - UITabelViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.mj_header endRefreshing];
    
    
    if(tableView == self.categoryTableView){
        self.params = nil;
               
        YFCategory *category = self.categories[indexPath.row];
        
        if(category.users.count){
            [self.userTableView reloadData];
            
        }else{
            [self.userTableView reloadData];
            [self.userTableView.mj_header beginRefreshing];
        }
        
        
        
        
        
    }

    
    
    
   
    

    
}

@end
