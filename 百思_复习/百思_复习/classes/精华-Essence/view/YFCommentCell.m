//
//  YFCommentCell.m
//  百思_复习
//
//  Created by 钟永发 on 16/8/23.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFCommentCell.h"
#import "YFComment.h"
#import <UIImageView+WebCache.h>
@interface YFCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sexIcon;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@end

@implementation YFCommentCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    YFCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    }
    
    return cell;
}


-(void)setComment:(YFComment *)comment
{
    _comment = comment;
    
    YFCommentUser *user = comment.user;
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:user.profile_image] placeholderImage:[UIImage imageNamed:@"DefaultUserIcon"] completed:nil];
    
    
    self.nameLabel.text = user.username;
    
    self.contentLabel.text = comment.content;
    
    if([comment.user.sex isEqualToString:@"m"]){
        self.sexIcon.image = [UIImage imageNamed:@"Profile_manIcon"];
        
    }else{
        self.sexIcon.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    self.likeCount.text = comment.like_count;
    
    if(comment.voiceuri.length){
        self.contentLabel.hidden = YES;
        [self.voiceBtn setTitle:[NSString stringWithFormat:@"%ld",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceBtn.hidden = YES;
        self.contentLabel.hidden = NO;
    }
    

    
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headImageV.layer.cornerRadius = self.headImageV.width * 0.5;
    self.layer.masksToBounds  = YES;
}
- (IBAction)voiceClick:(id)sender {
    
}
- (IBAction)likeBtnClick:(id)sender {
}
@end
