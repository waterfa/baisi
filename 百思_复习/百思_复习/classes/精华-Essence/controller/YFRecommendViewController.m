//
//  YFRecommendViewController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/21.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFRecommendViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YFCommend.h"
#import "YFRecommendCell.h"
#import <objc/runtime.h>
#import "YFSearchField.h"

@interface YFRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet YFSearchField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 存放模型的数组 */
@property(nonatomic,strong)NSMutableArray *recommends;
@end

@implementation YFRecommendViewController
-(NSMutableArray *)recommends
{
    if(!_recommends)
    {
        _recommends = [NSMutableArray array];
        
    }
    return _recommends;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   unsigned int count ;
    Ivar *ivars = class_copyIvarList([self.textField class], &count);
    NSLog(@"%d",count);
    for(int i = 0;i<count;i++)
    {
        Ivar ivar = *(ivars+i);
        
        NSLog(@"%s",ivar_getName(ivar));
    }
    
//    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header_cry_icon"]] ;
//    imageV.size = imageV.image.size;
//    
//    
//    [self.textField setValue:imageV forKey:@"_backgroundView"];
//    imageV.center  = imageV.superview.center;
    
    
    self.navigationItem.title = @"推荐标签";
    //自动行高
    self.tableView.estimatedRowHeight = 100;
    //调整高度
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupRequest];
}

/** 发送请求 */
-(void)setupRequest
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *commends = [YFCommend mj_objectArrayWithKeyValuesArray:responseObject];
        [self.recommends addObjectsFromArray:commends];
        
        [self.tableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"加载失败");
    }];
    
    
}


#pragma mark - <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommends.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YFRecommendCell *cell = [YFRecommendCell cellWithTableView:tableView];
    
    cell.recommend = self.recommends[indexPath.row];
    
    
    return cell;
    
}




@end
