//
//  YFEssenceViewController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/18.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFEssenceViewController.h"
#import "YFTopicsViewController.h"

#define tableViewH YFScreenH - 64-35-44

@interface YFEssenceViewController () <UIScrollViewDelegate>

/** 选中的按钮 */
@property(nonatomic,weak)UIButton *selectBtn;
/** titleView */
@property(nonatomic,strong)UIView *titlesView;
/** 底部红色条 */
@property(nonatomic,strong)UIView *bottomView;
/** scrollview */
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation YFEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupNav];
    
    
    
    [self setupContentScrollView];
    [self setupTitleView];
    
    [self addChildViewControllers];
    
    
    [self setframe];
}

-(void)addChildViewControllers
{
    YFTopicsViewController *all = [[YFTopicsViewController alloc]init];
    all.subtitle = @"全部";
    [self addChildViewController:all];
    [self.scrollView addSubview:all.view];
    
    YFTopicsViewController *video = [[YFTopicsViewController alloc]init];
    video.subtitle = @"视频";
    [self addChildViewController:video];
    [self.scrollView addSubview:video.view];
    
    YFTopicsViewController *picture = [[YFTopicsViewController alloc]init];
    picture.subtitle = @"图片";
    [self addChildViewController:picture];
    [self.scrollView addSubview:picture.view];
    
    YFTopicsViewController *word = [[YFTopicsViewController alloc]init];
    word.subtitle = @"段子";
    [self addChildViewController:word];
    [self.scrollView addSubview:word.view];
    
    YFTopicsViewController *voice = [[YFTopicsViewController alloc]init];
    voice.subtitle = @"声音";
    [self addChildViewController:voice];
    [self.scrollView addSubview:voice.view];
}

//设置子控制器的frame
-(void)setframe
{
    
    for(int i=0;i<self.childViewControllers.count;i++){
        
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i* YFScreenW, 0, YFScreenW, YFScreenH);
    }
     self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * YFScreenW    , 0);
}
-(void)setupContentScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc]init];
    scroll.frame = self.view.bounds;

//    scroll.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scroll];
    self.scrollView = scroll;
    scroll.delegate = self;

    scroll.pagingEnabled = YES;
    scroll.bounces = NO;
    
}
-(void)setupTitleView
{
    NSArray *titles = @[@"全部",@"视频",@"图片",@"段子",@"声音"];
    
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 64, YFScreenW, 35);
    titleView.backgroundColor = [YFGobalColor colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    self.titlesView = titleView;
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
    
    NSInteger index = [self.titlesView.subviews indexOfObject:btn] -1;
    CGPoint offsex = self.scrollView.contentOffset;
    offsex.x =  index * YFScreenW;
    
    [self.scrollView setContentOffset:offsex animated:YES];
    
    
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


#pragma mark - <UIScrollViewDelegate>


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = (int)(scrollView.contentOffset.x /YFScreenW);
    
    UIButton *btn = self.titlesView.subviews[index+1];
    
    [self titleBtnClick:btn];
    
}

@end
