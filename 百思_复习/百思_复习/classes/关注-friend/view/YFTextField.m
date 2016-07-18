//
//  YFTextField.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/18.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFTextField.h"

@implementation YFTextField

-(void)awakeFromNib
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
}

-(BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    self.tintColor = self.textColor;
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
@end
