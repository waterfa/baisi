//
//  YFCommentCell.h
//  百思_复习
//
//  Created by 钟永发 on 16/8/23.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFComment;

@interface YFCommentCell : UITableViewCell

/** model */
@property(nonatomic,strong) YFComment *comment;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
