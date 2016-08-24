//
//  YFVerticalyBtn.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/18.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFVerticalyBtn.h"

@implementation YFVerticalyBtn

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.imageView.frame = CGRectMake(0, 0, self.width, self.width);
    
    
    
    
    self.titleLabel.frame = CGRectMake(0, self.width+5, self.width, self.height - self.width-5);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

@end
