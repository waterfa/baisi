//
//  YFShowTopViewController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/20.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFShowTopViewController.h"

@interface YFShowTopViewController ()

@end

@implementation YFShowTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self searchScrollViewinView:window];
        
    
}

-(void)searchScrollViewinView:(UIView *)superview
{
    for(UIScrollView *scrollView in superview.subviews){
        
        if([scrollView isKindOfClass:[UIScrollView class]] && [scrollView isShowOnWindow]){
            
            CGPoint offset = scrollView.contentOffset;
            
            offset.y = -scrollView.contentInset.top;
            
            [scrollView setContentOffset:offset animated:YES];
        }
        
        [self searchScrollViewinView:scrollView];
    }
}
@end
