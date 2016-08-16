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


@interface YFCommentController ()
/** 最热评论 */
@property(nonatomic,strong)NSArray *top_cmt;
/** 评论 */
@property(nonatomic,strong)NSMutableArray *comments;

/** 当前页 */
@property(nonatomic,assign)NSInteger page;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%ld",self.topic.top_cmt.count);
    
    
    
    YFTWordCell *cell = [YFTWordCell word];
    cell.topic = self.topic;
    cell.height =  self.topic.cellHeight;
    
    self.tableView.tableHeaderView = cell;
    
    [self setupRequest];
}

-(void)setupRequest{
    NSInteger page = self.page + 1;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.id;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //---
//        NSLog(@"%@",responseObject);
        
        NSArray *comment = [YFComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.comments addObjectsFromArray:comment];
        
        self.top_cmt = [YFComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        NSLog(@"%ld",self.comments.count);
        
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //lll
        NSLog(@"lost");
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    
    if(self.top_cmt.count>0 && indexPath.section ==0){
        YFComment *comment = self.top_cmt[indexPath.row];
        
        cell.textLabel.text = comment.content;
    }else{
        YFComment *comment = self.comments[indexPath.row];
        
        cell.textLabel.text = comment.content;
    }
    
    
    return cell;
}



-(void)setTopic:(YFTopics *)topic
{
    _topic = topic;
    
}

@end
