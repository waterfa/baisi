//
//  YFEssenceViewController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/18.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFEssenceViewController.h"
#import "YFTopicsViewController.h"
#import "YFRecommendViewController.h"
#import <AVFoundation/AVFoundation.h>

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

/** voice */
@property(nonatomic,strong)AVPlayer *avPlayer;

/** voiceurl */
@property(nonatomic,strong)NSString *voiceurl;
@end

@implementation YFEssenceViewController
-(AVPlayer *)avPlayer
{
    if(!_avPlayer)
    {
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:nil]];
        _avPlayer = [AVPlayer playerWithPlayerItem:item];
        
    }
    return _avPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupNav];
    
    
    [self setupContentScrollView];
    [self addChildViewControllers];
    [self setupTitleView];
    
    __block typeof(self) weakSelf = self;
    [self setVBlock:^(NSString *url ,BOOL play){
        
        
        if(!play){
            if(![weakSelf.voiceurl isEqualToString:url]){
                AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
                [weakSelf.avPlayer replaceCurrentItemWithPlayerItem:item];
                weakSelf.voiceurl = url;
                
            }
            [weakSelf.avPlayer play];
        }else{
            [weakSelf.avPlayer pause];
        }
        
    }];
    
    
}

-(void)addChildViewControllers
{
    YFTopicsViewController *all = [[YFTopicsViewController alloc]init];
    all.title = @"全部";
    all.type = topicsTypeAll;
    [self addChildViewController:all];

    
    YFTopicsViewController *video = [[YFTopicsViewController alloc]init];
    video.title = @"视频";
    video.type = topicsTypeVideo;
    [self addChildViewController:video];
    
    YFTopicsViewController *picture = [[YFTopicsViewController alloc]init];
    picture.title = @"图片";
    picture.type = topicsTypePicture;
    [self addChildViewController:picture];
    
    YFTopicsViewController *word = [[YFTopicsViewController alloc]init];
    word.title = @"段子";
    word.type = topicsTypeWord;
    [self addChildViewController:word];
    
    YFTopicsViewController *voice = [[YFTopicsViewController alloc]init];
    voice.title = @"声音";
    voice.type = topicsTypeVoice;
    [self addChildViewController:voice];
    
    //设置ScrollView 的contentSzie
    self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * YFScreenW    , 0);
    
    //显示第一个子控制器
    UITableViewController *vc = self.childViewControllers[0];
    vc.tableView.frame = self.scrollView.bounds;
    [self.scrollView addSubview:vc.view];
}

////设置子控制器的frame
//-(void)setframe
//{
//    
//    for(int i=0;i<self.childViewControllers.count;i++){
//        
//        UIViewController *vc = self.childViewControllers[i];
//        vc.view.frame = CGRectMake(i* YFScreenW, 0, YFScreenW, YFScreenH);
//    }
//    ;
//}
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
    
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 64, YFScreenW, 35);
    titleView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    //底部红色条
    UIView *bottomV = [[UIView alloc]init];
    bottomV.frame = CGRectMake(0, 32, 20, 3);
    bottomV.backgroundColor = [UIColor redColor];
    [titleView addSubview:bottomV];
    self.bottomView = bottomV;
    
    NSInteger count = self.childViewControllers.count;
    CGFloat w = YFScreenW /count;
    for (int i = 0; i<count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
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
    YFRecommendViewController *vc = [[YFRecommendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - <UIScrollViewDelegate>


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = (int)(scrollView.contentOffset.x /YFScreenW);
    
    UIButton *btn = self.titlesView.subviews[index+1];
    
    [self titleBtnClick:btn];
    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    
    NSInteger index = scrollView.contentOffset.x /YFScreenW;
    
    
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.tableView.y = 0;
    vc.view.height = scrollView.height;
    vc.view.width = scrollView.width;
    
    [scrollView addSubview:vc.view];
    
}
@end
