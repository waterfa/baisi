//
//  YFTopics.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/19.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFTopics.h"

@implementation YFTopics

-(CGFloat)cellHeight
{
    if(!_cellHeight)
    {
        CGSize maxSize = CGSizeMake(YFScreenW - YFTopicMargin * 2, MAXFLOAT);
        CGFloat labelH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}  context:nil].size.height;
        
        CGFloat labelY = 70 ;
        _cellHeight = labelH + labelY +YFTopicMargin ;
        
        if(self.type == topicsTypePicture){
            
            CGFloat w = YFScreenW - 2 * YFTopicMargin;
            
            CGFloat h = w * self.height /self.width;
            if(h > 400) {
                h = 400;
                self.BigPicture = YES;
            };
            
            CGFloat x = YFTopicMargin;
            CGFloat y = labelH + 70 + YFTopicMargin;
            
            _pictureF = CGRectMake(x, y , w , h);
            
            
            
            
            _cellHeight += h + YFTopicMargin;
        }
        
        
        _cellHeight += 35+YFTopicMargin ;
    }
    return _cellHeight;
}
@end
