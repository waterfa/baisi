//
//  XMGAddTagViewController.m
//  01-百思不得姐
//
//  Created by 钟永发 on 16/7/10.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "XMGAddTagViewController.h"
#import "XMGTagButton.h"
#import "XMGTagTextField.h"
#import <SVProgressHUD.h>

@interface XMGAddTagViewController ()<UITextFieldDelegate>

/** contentView */
@property(nonatomic,weak)UIView *contentView;
/** 文本输入框 */
@property(nonatomic,weak)XMGTagTextField *textField;
/** 标签按钮 */
@property(nonatomic,weak)UIButton *addBtn;
/** 所有的标签按钮 */
@property(nonatomic,strong)NSMutableArray *tagButtons;
@end

@implementation XMGAddTagViewController
#pragma mark - 懒加载
-(NSMutableArray *)tagButtons
{
    if(!_tagButtons)
    {
        _tagButtons = [NSMutableArray array];
        
    }
    return _tagButtons;
}

-(UIButton *)addBtn
{
    if(!_addBtn)
    {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.width = self.contentView.width;
        addBtn.height = 35;
        addBtn.backgroundColor = YFTagColor;
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.contentEdgeInsets = UIEdgeInsetsMake(0, YFTagMargin, 0, YFTagMargin);
        //让按钮内部的文字和图片都左对齐，
        addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [self.contentView addSubview:addBtn];
        [addBtn addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _addBtn = addBtn;
    }
    return _addBtn;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextField];
    
    [self setupTags];
}
-(void)setupTags
{
    for(NSString *tag in self.tags)
    {
        self.textField.text = tag;
        [self addButtonClick];
    }
}
-(void)setupContentView
{
    UIView *contentview = [[UIView alloc]init];
    contentview.frame = CGRectMake(YFTagMargin, 64+YFTagMargin, self.view.width- 2* YFTagMargin, YFScreenH);

    [self.view addSubview:contentview];
    self.contentView = contentview;
    
}

-(void)setupTextField
{
    XMGTagTextField *textfeild = [[XMGTagTextField alloc]init];
    
    textfeild.size = CGSizeMake(self.contentView.width, 25);

    textfeild.placeholder = @"多个标签用逗号或换行隔开";
    //注意：懒加载必须要设置了以后才能有KVC
    
    textfeild.delegate = self;
    
    __weak typeof(self)weakSelf = self;
    textfeild.deleteBlock = ^{
      
        if(weakSelf.textField.hasText) return ;
            
            [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
        
    };
    [textfeild addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [textfeild becomeFirstResponder];
    [self.contentView addSubview:textfeild];
    self.textField = textfeild;
}
-(void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finish)];
}


#pragma mark -监听按钮点击
-(void)finish
{
    //传递数据到上一个控制器
//    NSMutableArray *tags = [NSMutableArray array];
//    for(XMGTagButton *tagBtn in self.tagButtons){
//        [tags addObject:tagBtn.currentTitle];
//    }
    NSArray *tags = [self.tagButtons valueForKey:@"currentTitle"];
    !self.tagsBlok ? : self.tagsBlok(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}
//标签按钮的点击
-(void)tagButtonClick:(UIButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    //更新所有标签的按钮
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
    
}
-(void)addButtonClick
{
    if(self.tagButtons.count == 5){
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"最多添加五个" ];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        
        
//        [self.tagButtons removeLastObject];
        return;
    }
    //1.添加一个标签按钮
    XMGTagButton *tagButton = [XMGTagButton buttonWithType:UIButtonTypeCustom];
    
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    
    
    //2.更新标签按钮的frame
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
    
    //3.清空textfield文字
    self.textField.text = nil;
    self.addBtn.hidden = YES;
    
    
    
}


#pragma mark -文字改变
-(void)textDidChange
{
    
    
    if(self.textField.hasText){
        //有文字。显示添加标签的按钮
        
        self.addBtn.hidden = NO;
        self.addBtn.y = CGRectGetMaxY(self.textField.frame)+YFTopicMargin;
        [self.addBtn setTitle:[NSString stringWithFormat:@"添加标签：%@",self.textField.text] forState:UIControlStateNormal];
        
        //获得最后一个字符
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len-1] ;
        if(([lastLetter isEqualToString:@","] || [lastLetter isEqualToString:@"，"]) ){
            self.textField.text  = [text substringToIndex:len-1];
            
            [self addButtonClick];
        }
    }else
    {//没有文字
        //隐藏添加标签的按钮
        self.addBtn.hidden = YES;
        
    }
    
    //更新标签文本框的宽度
    [self updateTextFieldFrame];
}

#pragma mark - 更新Frame
-(void)updateTagButtonFrame
{
    //更新标签按钮的frame
    for(int i = 0;i<self.tagButtons.count;i++)
    {
        UIButton *tagButton = self.tagButtons[i];
        if(i==0){ //最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
            
            
        }else{ //其他按钮
            UIButton *lastTagButton = self.tagButtons[i-1];
            CGFloat leftwidth = CGRectGetMaxX(lastTagButton.frame) + YFTagMargin;
            CGFloat rightwith = self.contentView.width - leftwidth;
            
            if(rightwith >= tagButton.width){
                //按钮显示在当前行
                tagButton.y = lastTagButton.y;
                tagButton.x = leftwidth;
            }else { //换行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + YFTagMargin;
            }
        }
    }
    

    
    
}

-(void)updateTextFieldFrame
{
    //更新textFeild的frame
    UIButton *lastBtn = [self.tagButtons lastObject];
    CGFloat leftwidth = CGRectGetMaxX(lastBtn.frame) + YFTagMargin ;
    CGFloat rightwidth = self.contentView.width - leftwidth;
    
    if(rightwidth >= [self textFieldTextWidth]){
        self.textField.y = lastBtn.y;
        self.textField.x = leftwidth;
    }else
    {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastBtn.frame)+ YFTagMargin;
    }
    
    //更新添加标签按钮的frame
    self.addBtn.y = CGRectGetMaxY(self.textField.frame)+ YFTagMargin;
}
//textField文字的宽度
-(CGFloat)textFieldTextWidth
{
    CGFloat textw =  [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    
    return MAX(100,textw);
}


#pragma mark -<UITextFieldDelegate>
//监听键盘右下角按钮的点击（return key,比如“换行”、“完成"等等)
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.hasText){
        [self addButtonClick];
    }
    return YES;
}
@end
