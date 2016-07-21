//
//  YFPushGuideView.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/21.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFPushGuideView.h"

@implementation YFPushGuideView

+(void)show
{
    
    //获取当前版本号
    NSString *key = @"CFBundleShortVersionString";
    
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    //获取沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if(![version isEqualToString:sanboxVersion]){ //时候第一次打开
        
        //显示向导
        UIWindow *winodw = [UIApplication sharedApplication].keyWindow;
        
        YFPushGuideView *view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
        view.frame = winodw.bounds;
        
        [winodw addSubview:view];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        
        //让系统接收用户默认设置 ******8
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
   
    
}
- (IBAction)close:(id)sender {
    
    [self removeFromSuperview];
}
@end
