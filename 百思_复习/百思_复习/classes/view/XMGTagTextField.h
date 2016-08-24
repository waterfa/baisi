//
//  XMGTagTextField.h
//  01-百思不得姐
//
//  Created by 钟永发 on 16/7/10.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGTagTextField : UITextField
/** 按了删除键后的回调 */
@property(nonatomic,copy)void (^deleteBlock)();
@end
