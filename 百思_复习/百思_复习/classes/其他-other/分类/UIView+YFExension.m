//
//  UIView+YFExension.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/16.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "UIView+YFExension.h"

@implementation UIView (YFExension)

-(void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    
    rect.origin.x = x;
    self.frame = rect;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    
    rect.origin.y = y;
    self.frame = rect;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    
    rect.size.width = width;
    self.frame = rect;
}
-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    
    rect.size.height = height;
    self.frame = rect;
}
-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}
-(CGSize)size
{
    return self.frame.size;
}



-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(CGFloat)centerX
{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)centerY
{
    return self.center.y;
}

-(BOOL)isShowOnWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect newframe = [window convertRect:self.frame fromView:self.superview];
    
    CGRect windowBounds = window.bounds;
    
    BOOL intersects = CGRectIntersectsRect(newframe, windowBounds);
    
    return !self.hidden&& self.alpha>0.01 && intersects && self.window == window ;
}
@end
