//
//  YFSearchField.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/21.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFSearchField.h"

@implementation YFSearchField

-(void)awakeFromNib
{
//    [self setValue:[UIColor redColor] forKeyPath:@"backgroundColor"];
//    self.backgroundColor
    
    
    
}

-(void)drawRect:(CGRect)rect
{
    
    UIImage *image = [UIImage imageNamed:@"header_cry_icon"];
    CGPoint center = self.center;
    NSLog(@"%@",NSStringFromCGPoint(center));
    
    CGFloat h = self.height;
    CGFloat w = image.size.width * h /image.size.height;
    
    CGFloat x = center.x - w *0.5;
    CGFloat y =- 0 * 0.5;
//    [image drawAtPoint:CGPointZero];
    
//    NSLog(@"%@",NSStringFromCGRect(rect));
    [image drawInRect:CGRectMake(x, y , w, h )];
    
}
@end
