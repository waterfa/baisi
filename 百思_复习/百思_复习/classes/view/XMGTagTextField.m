//
//  XMGTagTextField.m
//  01-百思不得姐
//
//  Created by 钟永发 on 16/7/10.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "XMGTagTextField.h"

@implementation XMGTagTextField


-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = YFTagH;
    }
    return self;
}
-(void)deleteBackward
{
    
    
    !self.deleteBlock ? :self.deleteBlock();
    
    [super deleteBackward];
}

@end
