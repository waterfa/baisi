//
//  XMGPlaceholderTextView.m
//  01-百思不得姐
//
//  Created by 钟永发 on 16/7/8.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "XMGPlaceholderTextView.h"


@interface XMGPlaceholderTextView ()

/** 显示占位文字的label */
@property(nonatomic,weak)UILabel *placeholderLabel;

@end

@implementation XMGPlaceholderTextView
-(UILabel *)placeholderLabel
{
    if(!_placeholderLabel)
    {
        //添加一个用来显示占位文字的label
        UILabel *placehoderlabel = [[UILabel alloc]init];
        placehoderlabel.numberOfLines = 0;
        placehoderlabel.x = 3;
        placehoderlabel.y = 8;
        [self addSubview:placehoderlabel];
        _placeholderLabel = placehoderlabel;
        
    }
    return _placeholderLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //垂直方向永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        self.font = [UIFont systemFontOfSize:15];
        
        
        
        //默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        
        //监听文字的改变
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        

        
        
    }
    return self;
}
-(void)textDidChange
{
    //只要有文字，就隐藏placeholderLabel
    self.placeholderLabel.hidden = self.hasText;
    
}

#pragma mark - 重写setter方法
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    
    self.placeholderLabel.textColor = placeholderColor;
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    
    self.placeholderLabel.text = _placeholder;
//    [self updatePlaceholderLabelSize];
   
    [self setNeedsLayout];
}
////方法1.
//-(void)updatePlaceholderLabelSize
//{
//    
//    CGSize maxSize = CGSizeMake(YFScreenW - 2*self.placeholderLabel.x, MAXFLOAT);
//    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
//}
//    //方法2.
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLabel.width = self.width - 2* self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];

}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    //方法1
//    [self updatePlaceholderLabelSize];
    //方法2
    [self setNeedsLayout];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}




////每次调用drawRect:之前都会清掉之前绘制的内容
//-(void)drawRect:(CGRect)rect
//{
//    //如果有文字（输入了文字）不绘制占位文字
////    if(self.text.length || self.attributedText.length) return;
//    if(self.hasText) return; //有文字直接返回
//    
////    XMGLog(@"%@",NSStringFromCGRect(rect));
//    //文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = self.font;
//    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
//    
//    rect.origin.x = 3;
//    rect.origin.y = 8;
//    rect.size.width -=  2 * rect.origin.x;
//    
//    [self.placeholder drawInRect:rect withAttributes:attrs];
//}

-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * setNeedsDidsplay方法： 会在恰当的时刻自动调用drawRect:方法
 * setNeedsLayout :会在恰当的时刻调用layoutSubview方法
 */
@end
