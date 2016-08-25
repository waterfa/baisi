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
#import "YFEssenceViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface YFVoiceCell ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

/** AVPlayer */
//@property(nonatomic,strong)AVPlayer *avPlayer;
/** url */
//@property(nonatomic,strong)NSString *voiceurl;



@end
@implementation YFVoiceCell
//-(AVPlayer *)avPlayer
//{
//    if(!_avPlayer)
//    {
//        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:nil];
//        _avPlayer = [AVPlayer playerWithPlayerItem:item];
//        
//    }
//    return _avPlayer;
//}

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
    
    self.voiceBtn.selected = topic.selected;
    
}
- (IBAction)voiceBtnClick:(UIButton *)sender {
    
    YFEssenceViewController *vc = [self viewController];
    NSLog(@"%@",vc);
    
    vc.VBlock(self.topic.voiceuri,sender.selected);
    sender.selected = !sender.selected;
    
    self.topic.selected = sender.selected;
    
//    if(sender.selected)
//    {
//        if(![self.voiceurl isEqualToString:self.topic.voiceuri])
//        {
//            [self.avPlayer pause];
//            AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
//
//            [self.avPlayer replaceCurrentItemWithPlayerItem:item];
//        }
//            [self.avPlayer play];
//    }else
//    {
//        [self.avPlayer pause];
//    }

}

//获取当前控制器
- (YFEssenceViewController*)viewController {
    YFEssenceViewController *vc;
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            vc = (YFEssenceViewController*)nextResponder;
            break;
        }

    }
    if(![vc isKindOfClass:[YFEssenceViewController class]]){
        
        return vc.navigationController.viewControllers[0];
    }
    
    return nil;
}
@end
