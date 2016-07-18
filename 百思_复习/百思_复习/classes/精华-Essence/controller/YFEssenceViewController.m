//
//  YFEssenceViewController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/18.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFEssenceViewController.h"

@interface YFEssenceViewController ()

/** 选中的按钮 */
@property(nonatomic,weak)UIButton *selectBtn;
/** 底部红色条 */
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation YFEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupNav];
    
    [self setupTitleView];
}
-(void)setupTitleView
{
    NSArray *titles = @[@"全部",@"视频",@"图片",@"段子",@"声音"];
    
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 64, YFScreenW, 35);
    [self.view addSubview:titleView];
    
    //底部红色条
    UIView *bottomV = [[UIView alloc]init];
    bottomV.frame = CGRectMake(0, 32, 20, 3);
    bottomV.backgroundColor = [UIColor redColor];
    [titleView addSubview:bottomV];
    self.bottomView = bottomV;
    
    NSInteger count = titles.count;
    CGFloat w = YFScreenW /count;
    for (int i = 0; i<titles.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(w *i, 0, w, 35);
        
        [titleView addSubview:btn];
        
        if(i==0){
            self.selectBtn = btn;
            
            btn.selected = YES;
            
            [self titleBtnClick:btn];
        }
    }
    
   
    
}
-(void)titleBtnClick:(UIButton *)btn
{
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
    
    
    CGFloat w = [[btn titleForState:UIControlStateNormal] sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}].width;
    CGFloat centerX = btn.centerX;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.width = w;
        self.bottomView.centerX = centerX;
        
    }];
    
    
}
-(void)setupNav
{
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.titleView = imageV;
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(menuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(void)menuBtnClick
{
    NSLog(@"点击了菜单按钮");
}

@end
