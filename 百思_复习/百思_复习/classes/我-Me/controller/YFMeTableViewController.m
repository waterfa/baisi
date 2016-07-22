//
//  YFMeTableViewController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/21.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFMeTableViewController.h"
#import "YFFootView.h"

@interface YFMeTableViewController ()
/** height */
@property(nonatomic,strong)NSMutableArray *heights;
/** sss */
@property(nonatomic,assign)CGFloat height;

@end

@implementation YFMeTableViewController
-(NSMutableArray *)heights
{
    if(!_heights)
    {
        _heights = [NSMutableArray array];
        
    }
    return _heights;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = YFTopicMargin;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64-35+YFTopicMargin, 0, 44+10-35 +10, 0);
    
    //右边按钮
    
    //设置按钮
    UIButton *setting = [UIButton buttonWithType:UIButtonTypeCustom];
    [setting setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [setting setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [setting addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [setting sizeToFit];
    
    UIBarButtonItem *settingBar = [[UIBarButtonItem alloc]initWithCustomView:setting];
    
    //夜间模式按钮
    UIButton *moon = [UIButton buttonWithType:UIButtonTypeCustom];
    [moon setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [moon setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    [moon addTarget:self action:@selector(moon) forControlEvents:UIControlEventTouchUpInside];
    [moon sizeToFit];
    UIBarButtonItem *moonBar = [[UIBarButtonItem alloc]initWithCustomView:moon];
    
    
    self.navigationItem.rightBarButtonItems = @[settingBar,moonBar ];
    
    //footView 按钮处理
//    self.tableView.tableFooterView = [[YFFootView alloc]init];
//    self.tableView.height = 1000;
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(run:) name:@"fuck" object:nil];
    
}
-(void)run:(NSNotification *)note
{
    self.height = [note.userInfo[@"height"] doubleValue];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)setting
{
    YFLogFunc;
}
-(void)moon
{
    YFLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YFFootView *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if(cell == nil){
        
        cell = [[YFFootView  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if(indexPath.section == 0){
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.section == 1)
    {
        cell.textLabel.text = @"离线下载";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.section == 2){
        
        cell.footView = YES;
        
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2) return self.height;
    else return 44;

    
    
}

-(CGFloat )tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


@end
