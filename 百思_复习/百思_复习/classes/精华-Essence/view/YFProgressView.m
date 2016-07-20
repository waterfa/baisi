//
//  YFProgressView.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/19.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFProgressView.h"

@implementation YFProgressView
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f",progress * 100];
    [super setProgress:progress animated:YES];
}
@end
