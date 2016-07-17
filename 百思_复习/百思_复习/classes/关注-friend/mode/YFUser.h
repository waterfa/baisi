//
//  YFUser.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/16.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFUser : NSObject
/** 用户名城 */
@property(nonatomic,copy)NSString *screen_name;
/** 用户头像 */
@property(nonatomic,copy)NSString *header;
/** 被关注数量 */
@property(nonatomic,copy)NSString *fans_count;
/** 下一页 */
@property(nonatomic,assign)int total_page;
@end
