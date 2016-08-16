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
#import "YFShowPictureViewController.h"

@interface YFPictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *gifImage;
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet YFProgressView *progressView;



@end
@implementation YFPictureCell
- (IBAction)seeBigPic:(id)sender {
    
    [self showPicture];
}

- (void)awakeFromNib {
   
    self.mainImageView.userInteractionEnabled = YES;
    
    [self.mainImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
    
}

-(void)showPicture
{
    YFShowPictureViewController *vc = [[YFShowPictureViewController alloc]init];
//    vc.view.frame = [UIScreen mainScreen].bounds;
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:nil];
}

+(instancetype)picture
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)setTopic:(YFTopics *)topic
{
    _topic = topic;
    
    //加载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:topic.image2] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            //        CGFloat progress = (receivedSize * 1.0 )/(expectedSize * 1.0);
            //        [self.progressView setProgress:progress animated:YES];
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            
            //回到主线程
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //        self.progressView.hidden = YES;
                
                if(topic.BigPicture){
                    
                    
                    CGSize size = topic.pictureF.size;
                    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
                    CGFloat w = size.width;
                    CGFloat h = w * topic.height/ topic.width;
                    [image drawInRect:CGRectMake(0, 0, w, h)];
                    
                   UIImage *image2 = UIGraphicsGetImageFromCurrentImageContext();
                    
                    UIGraphicsEndImageContext();
                    
                    self.mainImageView.image =  image2;
                    
                }
            }];
            
            
                
              
        }];

    });
    
    
    self.seeBigBtn.hidden = !topic.BigPicture;
    NSString *str = [topic.image2 pathExtension];
    
    self.gifImage.hidden = ![str isEqualToString:@"gif"];
    
    
}
@end
