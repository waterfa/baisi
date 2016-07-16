//
//  YFFriendController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/16.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFFriendController.h"
#import "YFRecommendFriendController.h"

@interface YFFriendController ()

@end

@implementation YFFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"我的关注";
    

    //左边按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

-(void)leftBtnClick
{
    YFRecommendFriendController *vc = [[YFRecommendFriendController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
