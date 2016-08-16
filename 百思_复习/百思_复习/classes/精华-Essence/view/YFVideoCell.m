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
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <Masonry.h>

@interface YFVideoCell ()<AVPlayerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
/** player */
//@property(nonatomic,strong)AVPlayerViewController *playCV;
///** player */
@property(nonatomic,strong)AVPlayer *player;
/** layer */
@property(nonatomic,weak)AVPlayerLayer *playerLayer;

@end
@implementation YFVideoCell

-(AVPlayer *)player
{
    if(!_player)
    {
        AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.topic.videouri]];
        _player = [AVPlayer playerWithPlayerItem:item];
        
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        [self.layer addSublayer:layer];
        self.playerLayer = layer;
    }
    return _player;
}
//
//-(AVPlayerViewController *)playCV
//{
//    if(!_playCV)
//    {
//        _playCV = [[AVPlayerViewController alloc]init];
//        _playCV.delegate = self;
//        
//        [self addSubview:_playCV.view];
//        
//    }
//    return _playCV;
//}
- (IBAction)videoBtnClick:(UIButton *)sender {
//    
//    [self.playCV.player play];
//    self.playCV.view.hidden = NO;
    
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.topic.videouri]];
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    [self.player play];
    self.playerLayer.hidden = NO;
    self.imageView.hidden = YES;
}

- (void)awakeFromNib {
//    
//    [self.playCV.player pause];
//    self.playCV.view.hidden = YES;
    
    self.player = nil;
   
}


+(instancetype)video
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)setTopic:(YFTopics *)topic
{
    _topic = topic;
    

        [self.mainImage sd_setImageWithURL:[NSURL URLWithString:topic.image2]];
    
    [self.player pause];
            self.playerLayer.hidden = YES;

    
    
    
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.playCV.view.frame = self.bounds;
    
    self.playerLayer.frame = self.bounds;
}

-(void)dealloc
{
    NSLog(@"-----");
}

@end
