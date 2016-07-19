//
//  YFPictureCell.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/19.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFPictureCell.h"
#import <UIImageView+WebCache.h>
#import <UIImage+AFNetworking.h>
#import "YFTopics.h"

@interface YFPictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *gifImage;
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;



@end
@implementation YFPictureCell

- (void)awakeFromNib {
   
    
}

+(instancetype)picture
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)setTopic:(YFTopics *)topic
{
    _topic = topic;
    
    
    
    NSString *str = [topic.image0 pathExtension];
    
    self.gifImage.hidden = ![str isEqualToString:@"gif"];
    
    
}
@end
