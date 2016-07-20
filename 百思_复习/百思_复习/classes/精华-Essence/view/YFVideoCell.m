//
//  YFVideoCell.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/20.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFVideoCell.h"
#import <UIImageView+WebCache.h>
#import "YFTopics.h"

@interface YFVideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

@end
@implementation YFVideoCell

- (void)awakeFromNib {
   
    
}


+(instancetype)video
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)setTopic:(YFTopics *)topic
{
    _topic = topic;
    
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:topic.image2]];
    
}
@end
