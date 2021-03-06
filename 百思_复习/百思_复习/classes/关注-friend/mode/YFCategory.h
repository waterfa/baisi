//
//  YFCategory.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/16.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YFCategory : NSObject
/** name */
@property(nonatomic,copy)NSString *name;
/** 用户数 */
@property(nonatomic,copy)NSString *count;
/** id */
@property(nonatomic,assign)int id;

/** users */
@property(nonatomic,strong)NSMutableArray *users;
/** 总数 */
@property(nonatomic,assign) NSInteger total;
@end
