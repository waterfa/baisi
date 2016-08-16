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
#import "YFVideoCell.h"
#import "YFVoiceCell.h"
#import "YFComment.h"
#import "YFCommentUser.h"

@interface YFTWordCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewH;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIView *commentView;
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
/** 视频Cell */
@property(nonatomic,strong)YFVideoCell *video;
/** 声音 */
@property(nonatomic,strong)YFVoiceCell *voice;

@end
@implementation YFTWordCell
+(instancetype)word
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
-(YFVoiceCell *)voice
{
    if(!_voice)
    {
        _voice = [YFVoiceCell voice];
        [self.contentView addSubview:_voice];
    }
    return _voice;
}
-(YFPictureCell *)picture
{
    if(!_picture)
    {
        _picture = [YFPictureCell picture];
        [self.contentView addSubview:_picture];
        
    }
    return _picture;
}
-(YFVideoCell *)video
{
    if(!_video)
    {
        _video = [YFVideoCell video];
        [self.contentView addSubview:_video];
        
    }
    return _video;
}
- (void)awakeFromNib {
    
//    self.autoresizesSubviews = NO;
//    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    self.autoContentAccessingProxy
    self.width = [UIScreen mainScreen].bounds.size.width;
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
        self.picture.hidden = NO;
        
        self.video.hidden = YES;
        
    }else if(self.topic.type == topicsTypeVideo){
        
        self.video.topic = topic;
        self.video.frame = topic.pictureF;
        self.video.hidden = NO;
        
        self.picture.hidden = YES;
        self.voice.hidden = YES;
        
    }else if (self.topic.type == topicsTypeVoice)
    {
        self.voice.topic = topic;
        self.voice.frame = topic.pictureF;
        
        self.picture.hidden = YES;
        self.video.hidden = YES;
        self.voice.hidden = NO;
    }else
    {
        self.voice.hidden = YES;
        self.video.hidden = YES;
        self.picture.hidden = YES;
    }
    
    if(topic.top_cmt.count){
        self.commentView.hidden = NO;
        YFComment *comment = topic.top_cmt[0];
        self.commentViewH.constant = topic.commentViewH;
        self.commentLabel.text = [NSString stringWithFormat:@"%@ : %@",comment.user.username,comment.content ];
        
    }else
    {
        self.commentView.hidden = YES;
        
    }
    
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height = self.topic.cellHeight - YFTopicMargin;
    frame.origin.y += YFTopicMargin;
    [super setFrame:frame];
}


- (IBAction)menuClick:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"默默收藏了");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"默默举报了");
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}

@end
