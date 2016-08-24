//
//  XMGTagButton.m
//  01-百思不得姐
//
//  Created by 钟永发 on 16/7/10.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "XMGTagButton.h"


@implementation XMGTagButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = YFTagColor;
        
       
        
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    self.width += 3 * YFTagMargin;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = YFTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+YFTagMargin;
}
@end
