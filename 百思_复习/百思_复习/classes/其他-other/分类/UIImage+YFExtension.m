//
//  UIImage+YFExtension.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/21.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "UIImage+YFExtension.h"

@implementation UIImage (YFExtension)
-(instancetype)borderImage
{
    
    
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO/*透明*/, 0.0);
    
    //设置圆角矩形
    CGRect rect = {CGPointZero,self.size};
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.size.width *0.2];
//    //方法2.
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.size.width* 0.2, self.size.height* 0.2) ];
    
    //椭圆。
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:<#(CGRect)#> ];
    
    //裁剪
    [path addClip];
    
    //绘图
    [self drawAsPatternInRect:rect];
    
    //获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
    
    
}
@end
