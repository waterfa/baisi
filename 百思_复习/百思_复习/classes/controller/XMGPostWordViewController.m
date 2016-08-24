//
//  XMGPostWordViewController.m
//  01-百思不得姐
//
//  Created by 钟永发 on 16/7/8.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "XMGPostWordViewController.h"
#import "XMGPlaceholderTextView.h"
#import "XMGAddTagToolbar.h"

@interface XMGPostWordViewController ()<UITextViewDelegate>
/** text */
@property(nonatomic,strong)XMGPlaceholderTextView *text;
/** 工具条 */
@property(nonatomic,weak)XMGAddTagToolbar *toolbar;
@end

@implementation XMGPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
    
}

-(void)setupToolbar
{
    XMGAddTagToolbar *toolbar = [XMGAddTagToolbar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
//监听键盘的弹出隐藏
-(void)keyboardWillChangeFrame:(NSNotification *)note
{
    //键盘最终的Frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, keyboardF.origin.y -YFScreenH);
    }];
    
    
}
-(void)setupTextView
{
    XMGPlaceholderTextView *textview = [[XMGPlaceholderTextView alloc]init];
    textview.frame = self.view.bounds;
    textview.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
//    textview.frame = CGRectMake(0,0, 200, 300);
    textview.delegate = self;

    [self.view addSubview:textview];
    self.text = textview;
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //先退出之前键盘
    [self.view endEditing:YES];
    //在叫出键盘
    [self.text becomeFirstResponder];
}
-(void)setupNav
{
    self.view.backgroundColor = [UIColor redColor];
    
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;//默认不能点击
    //强制刷新(使按钮状态正常）
    [self.navigationController.navigationBar layoutIfNeeded];
}


-(void)cancle
{
    //退出键盘
    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    self.text.width = 100;

}
-(void)post
{
//    XMGLogFunc;
    
}

#pragma mark -<UITextViewDelegate>
-(void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
