//
//  YFLoginViewController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/18.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFLoginViewController.h"
#import <objc/runtime.h>

@interface YFLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *hadIDBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextFeild;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeftConstraint;

@end

@implementation YFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //登录按钮圆角
    UIImage *image =[UIImage imageNamed:@"loginBtnBg"];
    CGSize size = image.size;
    
    image = [image stretchableImageWithLeftCapWidth:size.width * 0.5 topCapHeight:size.height *0.5];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    
    //设置头像圆角
    self.registBtn.layer.cornerRadius = self.registBtn.height *0.2;
    self.registBtn.layer.masksToBounds = YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)regist:(id)sender {
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    if(self.loginLeftConstraint.constant==20){
        self.loginLeftConstraint.constant -= w;
        [self.hadIDBtn setTitle:@"已有账号" forState:UIControlStateNormal];
    }else
    {
        self.loginLeftConstraint.constant += w;
        [self.hadIDBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view layoutIfNeeded];
        
    }];
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)login:(id)sender {
    NSLog(@"点击了登录按钮");
}
- (IBAction)forgetPwd:(id)sender {
    NSLog(@"忘记密码？");
}


@end
