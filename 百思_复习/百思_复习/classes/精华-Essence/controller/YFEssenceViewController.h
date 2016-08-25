//
//  YFEssenceViewController.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/18.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void  (^voiceBlock )(NSString *url,BOOL play);

@interface YFEssenceViewController : UIViewController
/** type */
@property(nonatomic,strong)NSString *a;
/** block */
@property(nonatomic,copy)voiceBlock VBlock;

@end
