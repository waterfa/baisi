//
//  YFPictureCell.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/19.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFPictureCell.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageDownloader.h>
#import "YFProgressView.h"
#import "YFTopics.h"

@interface YFPictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *gifImage;
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet YFProgressView *progressView;



@end
@implementation YFPictureCell

- (void)awakeFromNib {
   
    
}

+(instancetype)picture
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)setTopic:(YFTopics *)topic
{
    _topic = topic;
    
    //加载图片
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = (receivedSize * 1.0 )/(expectedSize * 1.0);
        [self.progressView setProgress:progress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        if(topic.BigPicture){
            
            
            CGSize size = topic.pictureF.size;
            UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
            CGFloat w = size.width;
            CGFloat h = w * topic.height/ topic.width;
            [image drawInRect:CGRectMake(0, 0, w, h)];
            
            image = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            self.mainImageView.image = image;
            
            
        }
    }];
    
    self.seeBigBtn.hidden = !topic.BigPicture;
    NSString *str = [topic.image0 pathExtension];
    
    self.gifImage.hidden = ![str isEqualToString:@"gif"];
    
    
}
@end
