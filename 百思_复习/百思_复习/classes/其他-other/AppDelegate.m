//
//  AppDelegate.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/16.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "AppDelegate.h"
#import "YFTabBarController.h"
#import "YFNavController.h"
#import "YFShowTopViewController.h"
#import "YFPushGuideView.h"

@interface AppDelegate ()
/** window */
@property(nonatomic,strong)UIWindow *showWindow;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]init];
    
    
    YFTabBarController *tabVc = [[YFTabBarController alloc]init];
    
    
    self.window.rootViewController = tabVc;
    
    
    
    
    
    
    
    //添加跳到顶部功能
    UIWindow *window = [[UIWindow alloc]init];
    window.frame = CGRectMake(0, 0, YFScreenW, 20);
    window.windowLevel = UIWindowLevelAlert;
    window.backgroundColor = [UIColor clearColor];
    YFShowTopViewController *vc = [[YFShowTopViewController alloc]init];
    vc.view.frame = window.bounds;
    window.rootViewController =vc;
    window.hidden = NO;
    self.showWindow = window;
    
    [self.window makeKeyAndVisible];
    
    
    //添加向导View
    [YFPushGuideView show];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
