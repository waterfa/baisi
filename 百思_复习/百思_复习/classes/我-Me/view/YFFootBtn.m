//
//  YFFootBtn.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/21.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFFootBtn.h"
#import "YFMeBtnMode.h"
#import <UIButton+WebCache.h>

@implementation YFFootBtn

-(void)setMode:(YFMeBtnMode *)mode
{
    _mode = mode;
    
    
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    [self setTitle:mode.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:mode.icon] forState:UIControlStateNormal];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat h = self.height * 0.6;
    CGFloat margin = self.height * 0.1;
    self.imageView.frame = CGRectMake(self.width*0.5 - h*0.5,10, h, h);
    
    
    self.titleLabel.frame = CGRectMake(0,h+ margin, self.width, self.height - h-margin);
    
}
@end
