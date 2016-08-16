//
//  YFFootView.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/21.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFFootView : UITableViewCell
/** 高度 */
@property(nonatomic,assign)CGFloat  maxheight;
/** block */
@property(nonatomic,strong) void (^ablock)();
/** footView */
@property(nonatomic,assign)BOOL  footView;

-(void)setup;
@end
