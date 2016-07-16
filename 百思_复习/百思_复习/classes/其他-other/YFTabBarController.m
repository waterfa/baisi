//
//  YFTabBarController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/16.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFTabBarController.h"
#import "YFNavController.h"
#import "YFTabBar.h"
#import "YFFriendController.h"

@implementation YFTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    //添加子控制器
    
    [self addNavWithVC:[[UIViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    [self addNavWithVC:[[UIViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
    [self addNavWithVC:[[YFFriendController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    [self addNavWithVC:[[UIViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
 
    
    //更换tabBar
    [self setValue:[[YFTabBar alloc]init] forKey:@"tabBar"];
}

-(void)addNavWithVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage;
{
    vc.view.backgroundColor = YFGobalColor;
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    [vc.tabBarItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    attr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [vc.tabBarItem setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    YFNavController *vc1 = [[YFNavController alloc]initWithRootViewController:vc];
    
    
    
    
    
    [self addChildViewController:vc1];
}
@end
