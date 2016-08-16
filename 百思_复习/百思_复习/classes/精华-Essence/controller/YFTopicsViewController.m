//
//  YFTopicsViewController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/19.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFTopicsViewController.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <MJRefresh.h>
#import "YFTopics.h"
#import "YFTWordCell.h"
#import "YFEssenceViewController.h"
#import "YFCommentController.h"

@interface YFTopicsViewController ()
/** 存放模型的数组 */
@property(nonatomic,strong)NSMutableArray *topics;

/** 上一次传递的页码 */
@property(nonatomic,strong)NSString *maxtime;
@end

@implementation YFTopicsViewController
-(NSMutableArray *)topics
{
    if(!_topics)
    {
        _topics = [NSMutableArray array];
        
    }
    return _topics;
}

static NSString *const YFTopicID = @"topic";
- (void)viewDidLoad {
    [super viewDidLoad];
//
    
    self.tableView.backgroundColor = YFGobalColor;
    self.tableView.contentInset = UIEdgeInsetsMake(YFEssenceContentViewY, 0, YFTabBarH, 0);
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YFTWordCell class]) bundle:nil] forCellReuseIdentifier:YFTopicID];
//
    [self refresh];
    

}

-(void)refresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData) ];
    
}
-(void)loadMoreData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *topics = [YFTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.topics addObjectsFromArray:topics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)loadNewData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    YFEssenceViewController *vc = (YFEssenceViewController *) self.parentViewController ;
    
    params[@"a"] = vc.a ;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *topics = [YFTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.topics removeAllObjects];
        [self.topics addObjectsFromArray:topics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"加载失败");
        [self.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    YFTWordCell *cell = [tableView dequeueReusableCellWithIdentifier:YFTopicID];

    YFTopics *topic = self.topics[indexPath.row];
    
    cell.topic = topic;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YFTopics *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YFCommentController *vc = [[YFCommentController alloc]init];
    vc.topic = self.topics[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
