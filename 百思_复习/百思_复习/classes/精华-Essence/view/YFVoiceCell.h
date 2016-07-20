//
//  YFVoiceCell.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/20.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFTopics;
@interface YFVoiceCell : UITableViewCell

/** 模型 */
@property(nonatomic,strong)YFTopics *topic;

+(instancetype)voice;
@end
