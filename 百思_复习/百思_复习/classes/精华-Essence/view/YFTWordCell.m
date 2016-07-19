//
//  YFTWordCell.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/19.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFTWordCell.h"
#import <UIImageView+WebCache.h>
#import "YFTopics.h"
#import "YFPictureCell.h"


@interface YFTWordCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *create_time;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *VimageView;


/** 图片Cell */
@property(nonatomic,strong)YFPictureCell *picture;
@end
@implementation YFTWordCell
-(YFPictureCell *)picture
{
    if(!_picture)
    {
        _picture = [YFPictureCell picture];
        [self.contentView addSubview:_picture];
        
    }
    return _picture;
}

- (void)awakeFromNib {
}

-(void)setTopic:(YFTopics *)topic
{
    _topic = topic;
    
    
    self.nameLabel.text = topic.screen_name;
    self.create_time.text = topic.passtime;
    self.contentLabel.text = topic.text;
    
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:topic.profile_image]];
    
    [self.dingBtn setTitle:topic.ding forState:UIControlStateNormal];
    [self.caiBtn setTitle:topic.cai forState:UIControlStateNormal];
    [self.repostBtn setTitle:topic.repost forState:UIControlStateNormal];
    [self.commentBtn setTitle:topic.comment forState:UIControlStateNormal];
    
    
    self.VimageView.hidden = !topic.sina_v;
    
    if(self.topic.type == topicsTypePicture){
        
        self.picture.topic = topic;
        self.picture.frame = topic.pictureF;
        
    }
    
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height = self.topic.cellHeight - YFTopicMargin;
    frame.origin.y += YFTopicMargin;
    [super setFrame:frame];
}


- (IBAction)menuClick:(id)sender {
}

@end
