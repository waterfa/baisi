//
//  YFRecommendCell.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/21.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFCommend;

@interface YFRecommendCell : UITableViewCell
/** 模型 */
@property(nonatomic,strong)YFCommend *recommend;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
