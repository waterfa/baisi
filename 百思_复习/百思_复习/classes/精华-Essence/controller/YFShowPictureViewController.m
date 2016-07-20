//
//  YFShowPictureViewController.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/20.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFShowPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "YFTopics.h"
#import "YFProgressView.h"

@interface YFShowPictureViewController ()
@property (weak, nonatomic) IBOutlet YFProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@end

@implementation YFShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    [self.ScrollView addSubview:imageView];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image2] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = receivedSize *1.0 / expectedSize;
        
        [self.progressView setProgress:progress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        
        CGFloat w = YFScreenW;
        
        CGFloat h = YFScreenW * image.size.height / image.size.width;
        imageView.size = CGSizeMake(w, h);
        if(h <= YFScreenH){
            
            imageView.center = CGPointMake(YFScreenW * 0.5, YFScreenH * 0.5);
            self.ScrollView.contentSize = CGSizeZero;
        }else
        {
            imageView.frame = CGRectMake(0, 0, w, h);
            self.ScrollView.contentSize = CGSizeMake(0, h);
        }
        
        
        
        
    }];
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)]];
    
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)save:(id)sender {
    YFLogFunc;
}
- (IBAction)repost:(id)sender {
    
    YFLogFunc;
}


@end
