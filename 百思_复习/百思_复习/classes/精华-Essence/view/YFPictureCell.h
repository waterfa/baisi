//
//  YFPictureCell.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/19.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFTopics;
@interface YFPictureCell : UITableViewCell

/** 模型 */
@property(nonatomic,strong)YFTopics *topic;

+(instancetype)picture;
@end
