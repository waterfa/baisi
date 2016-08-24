//
//  XMGAddTagViewController.h
//  01-百思不得姐
//
//  Created by 钟永发 on 16/7/10.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGAddTagViewController : UIViewController

/** 获取tags的block */
@property(nonatomic,copy)void (^tagsBlok)();
/** 所有的标签 */
@property(nonatomic,strong)NSArray *tags;
@end
