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

@interface YFRecommendFriendController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 分类数组 */
@property(nonatomic,strong)NSArray *categories;

@end

@implementation YFRecommendFriendController

static NSString *const XMGCategoryID = @"category";
static NSString *const XMGUserID = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
 
    
    //注册
    [self.categoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:XMGCategoryID];
    [self.userTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:XMGUserID];
    
    [self setupRequest];
    
    //刷新界面
    [self setupRefresh];
    
}
-(void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
}
-(void)loadNewUsers
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"friend_recommend";
    params[@"c"] = @"user";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        
        [self.userTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
    
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
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"骑牛失败");
    }];
    
    
    
}



#pragma mark - <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCategoryID];
    
    YFCategory *category = self.categories[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",category.name];
    
    
    
    return cell;
    
    
}

#pragma mark - UITabelViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(tableView == self.categoryTableView){
//        
//    }
    [self.userTableView.mj_header beginRefreshing];
    
}

@end
