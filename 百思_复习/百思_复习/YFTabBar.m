//
//  YFTabBar.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/16.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFTabBar.h"

@interface YFTabBar ()

/** 发布按钮 */
@property(nonatomic,strong)UIButton *publishBtn;

@end
@implementation YFTabBar

-(void)setItems:(NSArray<UITabBarItem *> *)items
{
    YFLogFunc;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        publishBtn.size = publishBtn.currentImage.size;
        
        [publishBtn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    NSInteger count = self.items.count;
    
    CGFloat btnW = self.width /(count +1);
    NSInteger index = 0;
    for(int i = 0;i<self.subviews.count;i++){
        
        UIButton *item = self.subviews[i];
        if([item isKindOfClass:[UIControl class]] && item != self.publishBtn)
        {
            item.x = btnW * index;
            if(index>1){
                item.x  = btnW *(index+1);
            }
            item.width = btnW;
            index ++;
        }
    }
    
    self.publishBtn.center = CGPointMake(YFScreenW * 0.5, self.bounds.size.height *0.5);
    
    
}

-(void)publishBtnClick
{
    NSLog(@"点击了发布按钮");
}
@end
