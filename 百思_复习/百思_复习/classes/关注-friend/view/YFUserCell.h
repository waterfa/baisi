//
//  YFUserCell.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/16.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFUser;
@interface YFUserCell : UITableViewCell

/** 模型 */
@property(nonatomic,strong)YFUser  *user;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
