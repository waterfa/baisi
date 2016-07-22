//
//  YFComment.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/22.
//  Copyright © 2016年 facker. All rights reserved.
// 评论模型

#import <Foundation/Foundation.h>
@class YFCommentUser;
@interface YFComment : NSObject
/** 名字 */
//@property(nonatomic,strong)NS *<#name#>

/** 内容 */
@property(nonatomic,strong)NSString *content;
/** 点赞数 */
@property(nonatomic,strong)NSString *like_count;

/** 用户 */
@property(nonatomic,strong)YFCommentUser *user;
@end
