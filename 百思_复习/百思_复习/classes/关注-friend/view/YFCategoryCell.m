//
//  YFCategoryCell.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/17.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFCategoryCell.h"
#import "YFCategory.h"

@interface YFCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
@implementation YFCategoryCell

- (void)awakeFromNib {
    
    self.backgroundColor = YFGobalColor;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.redView.hidden = !selected;
    
    self.nameLabel.textColor = selected ?[UIColor redColor]: [UIColor grayColor];
}

-(void)setCategory:(YFCategory *)category
{
    _category = category;
    
    self.nameLabel.text = category.name;
    
}
@end
