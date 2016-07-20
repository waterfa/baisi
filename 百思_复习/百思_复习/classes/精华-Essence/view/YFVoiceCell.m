//
//  YFVoiceCell.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/20.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFVoiceCell.h"
#import "YFTopics.h"
#import <UIImageView+WebCache.h>

@interface YFVoiceCell ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;


@end
@implementation YFVoiceCell

+(instancetype)voice
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}


- (void)awakeFromNib {
    // Initialization code
}

-(void)setTopic:(YFTopics *)topic
{
    _topic = topic;
    
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:topic.image2]];
    
}

@end
