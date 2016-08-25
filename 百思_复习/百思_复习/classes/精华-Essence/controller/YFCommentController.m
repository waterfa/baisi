//
//  YFCommentController.m
//  百思_复习
//
//  Created by 钟永发 on 16/8/15.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFCommentController.h"
#import "YFTWordCell.h"
#import "YFTopics.h"
#import "YFComment.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YFCommentCell.h"
#import <MJRefresh.h>

@interface YFCommentController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property(nonatomic,strong)NSArray *top_cmt;
/** 评论 */
@property(nonatomic,strong)NSMutableArray *comments;

/** 当前页 */
@property(nonatomic,assign)NSInteger page;
/** 存放最热评论 */
@property(nonatomic,strong)NSArray *save_topcmt;
/** manger */
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

/** parmas */
@property(nonatomic,strong)NSDictionary *params;
@end

@implementation YFCommentController
-(NSMutableArray *)comments
{
    if(!_comments)
    {
        _comments = [NSMutableArray array];
        
    }
    return _comments;
}


-(AFHTTPSessionManager *)manager
{
    if(!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
     [self setupRefresh];
    
}
-(void)setupTableView
{
    
//    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    
    YFTWordCell *cell = [YFTWordCell word];
    
    if(self.topic.top_cmt.count >0){
        self.save_topcmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"_cellHeight"];
    }
    cell.topic = self.topic;
    cell.size = CGSizeMake(YFScreenW, self.topic.cellHeight);
    
    UIView *view = [[UIView alloc]init];
    [view addSubview:cell];
    view.height = self.topic.cellHeight;
    
    self.tableView.tableHeaderView = view;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = [UIColor orangeColor];
    
    //监听键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)keyboardChange:(NSNotification *)note
{
    NSDictionary *info = note.userInfo;
    
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
     self.bottomConstraint.constant = self.view.height - rect.origin.y;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}

-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.tableView.mj_header beginRefreshing];
    
    [self loadNewData];
    
}

-(void)loadNewData{
    
    
    //结束之前所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    
    params[@"hot"] = @"1";
    
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(params != self.params ) return ;
        
        if(![responseObject isKindOfClass:[NSDictionary class]]){
            //没有评论数据
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        
        //最新评论
        NSArray *comment = [YFComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.comments addObjectsFromArray:comment];
        
        //最热评论
        self.top_cmt = [YFComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        NSLog(@"%ld",(unsigned long)self.comments.count);
        
        self.page = 1;
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新控件
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSLog(@"lost");
        [self.tableView.mj_header endRefreshing];
    }];
    
}

-(void)loadMoreData
{
    //页码
    NSInteger page = self.page +1;
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    YFComment *cmt = [self.comments lastObject];
    
    params[@"lastcid"] = cmt.ID;
    
    self.params = params;
    
    //发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(self.params != params) return ;
        
        //最新评论
        NSArray *newComments = [YFComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.comments addObjectsFromArray:newComments];
        //页码
        self.page ++;
        
        //刷新表格
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if(self.comments.count >= total){
            //全部加载完毕
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            self.tableView.mj_footer.hidden = YES;
        }else
        {
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"lost");
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    self.tableView.mj_footer.hidden = self.comments.count ==0;
    
    if(self.top_cmt.count>0) return 2;
    else return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.top_cmt.count>0) {
        if(section == 0) return self.top_cmt.count;
        else return self.comments.count;
    }
    else {
      return self.comments.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YFCommentCell *cell = [YFCommentCell cellWithTableView:tableView];
    
    if(self.top_cmt.count>0 && indexPath.section ==0){
        YFComment *comment = self.top_cmt[indexPath.row];
        
        cell.comment = comment;
    }else{
        YFComment *comment = self.comments[indexPath.row];
        
        cell.comment = comment;
    }
    
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(self.top_cmt.count> 0 && section == 0) {
        
        return @"最热评论";
    }else{
        return @"最新评论";
    }
}

-(CGFloat )tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)dealloc
{
    if (self.save_topcmt) {
        self.topic.top_cmt = self.save_topcmt;
        [self.topic setValue:@0 forKey:@"_cellHeight"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //取消所有网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}
@end
