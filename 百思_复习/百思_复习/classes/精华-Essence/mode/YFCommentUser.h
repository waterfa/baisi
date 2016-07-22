//
//  YFCommentUser.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/22.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFCommentUser : NSObject
/** 头像URL */
@property(nonatomic,strong)NSString *profile_image;
/** 性别 */
@property(nonatomic,strong)NSString *sex;
/** 名字 */
@property(nonatomic,strong)NSString *username;
/** 是否会员 */
@property(nonatomic,strong)NSString *is_vip;
@end
