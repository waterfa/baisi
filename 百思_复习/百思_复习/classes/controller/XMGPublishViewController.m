//
//  XMGPublishViewController.m
//  01-百思不得姐
//
//  Created by 钟永发 on 16/6/29.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "XMGPublishViewController.h"
#import "YFVerticalyBtn.h"
#import <POP.h>
#import "XMGPostWordViewController.h"
//#import "XMGNavigationController.h"

static CGFloat const XMGAnimationDelay = 0.1;
static CGFloat const XMGSpringFactor = 10;
@interface XMGPublishViewController ()
/** 标语 */
@property(nonatomic,strong)UIImageView *sloganView;
///** block的属性声明 */
//@property(nonatomic,copy)void (^completionBlock)(); 
@end

@implementation XMGPublishViewController
- (IBAction)cancle:(id)sender {
    
    
    [self cancleWithCompletionBlock:nil];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    //数据
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    

    
    
    
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonstartY = (YFScreenH - 2*buttonH )*0.5;
    CGFloat buttonstartX = 30;
    int maxCols = 3;
    CGFloat marginX = (YFScreenW -maxCols *buttonW-buttonstartX*2) /(maxCols-1);
    //中间的6个按钮
    for(int i = 0;i<images.count;i++)
    {
        YFVerticalyBtn *button = [[YFVerticalyBtn alloc]init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        //设置frame
        int row = i / maxCols;
        int col = i % maxCols;
        
        CGFloat buttonX= buttonstartX + col *(marginX+buttonW);
        
        CGFloat buttonEndY = buttonstartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - YFScreenH;
        
        
        
        //添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];;
        anim.beginTime = CACurrentMediaTime() + XMGAnimationDelay *i;
        anim.springSpeed = XMGSpringFactor;
        anim.springBounciness = XMGSpringFactor;
        
        [button pop_addAnimation:anim forKey:nil];
    }
    
    //添加标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
    [self.view addSubview:sloganView];
 
    CGFloat centerEndX = YFScreenW *0.5;
    CGFloat centerY = YFScreenH * 0.2;
    CGFloat centerBeginX = centerEndX - YFScreenW;
    sloganView.centerX = centerBeginX;
    sloganView.centerY = centerY;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    
//    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerBeginX, centerY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerEndX, centerY)];
    anim.beginTime = CACurrentMediaTime() + images.count * XMGAnimationDelay;
    anim.springSpeed = XMGSpringFactor;
    anim.springBounciness = XMGSpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        //标语动画执行完毕，恢复动画
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    
    [self cancleWithCompletionBlock:nil];
}
//
-(void)cancleWithCompletionBlock:(void(^)())completionBlock
{
    //执行动画
    int beginIndex = 2;
    for(int i = beginIndex;i<self.view.subviews.count;i++)
    {
        
        UIView *subView = self.view.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY + YFScreenH ;
        //动画执行节奏（一开始慢，后块）
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue =  [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)] ;
        anim.beginTime = CACurrentMediaTime() + (i-beginIndex)* XMGAnimationDelay;
        if(i == self.view.subviews.count-1){
            NSValue *sloganValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX+YFScreenW, subView.centerY)];
            anim.toValue = sloganValue;
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
                [self dismissViewControllerAnimated:NO completion:nil];
                //执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
                
                
            }];
        }
        
        [subView pop_addAnimation:anim forKey:nil];
    }
}
-(void)buttonClick:(UIButton *)button
{
    [self cancleWithCompletionBlock:^{
//        if(button.tag ==2)
//        {
        
            XMGPostWordViewController *postword =[[XMGPostWordViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:postword];
//            //这里不能使用self来弹出控制器，因为self执行了dismiss操作
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:nav animated:YES completion:nil];
//        }
    }];
    
   
}

@end
