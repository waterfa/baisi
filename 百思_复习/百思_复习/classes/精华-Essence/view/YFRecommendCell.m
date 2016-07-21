//
//  YFRecommendCell.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/21.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFRecommendCell.h"
#import <UIImageView+WebCache.h>
#import "YFCommend.h"

@interface YFRecommendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;



@end

@implementation YFRecommendCell

static NSString *const YFRecommendID = @"recommend";

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    YFRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:YFRecommendID];
    if(cell == nil){
        cell =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    }
    
    return cell;
}

-(void)setRecommend:(YFCommend *)recommend
{
    _recommend = recommend;
    
//    [self.headImage sd_setImageWithURL:[NSURL URLWithString:recommend.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
//    //设置圆角
//    self.headImage.layer.cornerRadius = self.headImage.size.width * 0.2;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:recommend.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        self.headImage.image = [image borderImage];
    }];
    
    self.nameLabel.text = recommend.theme_name;
    
    NSString *str;
    NSInteger number = [recommend.sub_number integerValue];
    if(number>=10000){
        str = [NSString stringWithFormat:@"%.1f万人已订阅",number/10000.0];
    }else{
        str = [NSString stringWithFormat:@"%zd人已订阅",number];
    }
    self.recommendLabel.text = str;
    
}
- (IBAction)subscribe:(id)sender {
    
    NSLog(@"点击了订阅按钮");
}
@end
