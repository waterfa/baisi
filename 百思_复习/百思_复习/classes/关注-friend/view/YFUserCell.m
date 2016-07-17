//
//  YFUserCell.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/16.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFUserCell.h"
#import <UIImageView+WebCache.h>
#import "YFUser.h"

@interface YFUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendLabel;



@end
@implementation YFUserCell

static NSString *const YFUserID = @"user";
- (void)awakeFromNib {
   
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    YFUserCell *cell = [tableView dequeueReusableCellWithIdentifier:YFUserID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YFUserCell class]) owner:nil options:nil]lastObject];
    }
    
    
    return cell;
}

-(void)setUser:(YFUser *)user
{
    _user = user;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:user.header] ];
    
    self.nameLabel.text = user.screen_name;
    
    
    NSString *str = nil;
    NSInteger count = [user.fans_count integerValue];
    if(count >= 10000){
        str = [NSString stringWithFormat:@"%.1f万人关注",count/10000.0];
    }else
    {
        str = [NSString stringWithFormat:@"%zd人关注",count];
    }
    self.friendLabel.text = str;
    
    
}

@end
