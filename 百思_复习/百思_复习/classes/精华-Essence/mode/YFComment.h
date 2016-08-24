//
//  YFComment.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/22.
//  Copyright © 2016年 facker. All rights reserved.
// 评论模型

#import <Foundation/Foundation.h>
#import "YFCommentUser.h"
@interface YFComment : NSObject


/** 内容 */
@property(nonatomic,strong)NSString *content;
/** 点赞数 */
@property(nonatomic,strong)NSString *like_count;

/** 用户 */
@property(nonatomic,strong)YFCommentUser *user;
/** 音频文件的路经 */
@property(nonatomic,copy)NSString *voiceuri;
/** 音频文件的时长 */
@property(nonatomic,assign)NSInteger voicetime;
/** 评论的id */
@property(nonatomic,copy)NSString *ID;
@end
