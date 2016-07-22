//
//  YFTopics.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/19.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFTopics.h"
#import <MJExtension.h>
#import "YFComment.h"
#import "YFCommentUser.h"

@implementation YFTopics

-(CGFloat)cellHeight
{
    if(!_cellHeight)
    {
        CGSize maxSize = CGSizeMake(YFScreenW - YFTopicMargin * 2, MAXFLOAT);
        CGFloat labelH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}  context:nil].size.height;
        
        CGFloat labelY = 70 ;
        _cellHeight = labelH + labelY +YFTopicMargin ;
        
        CGFloat w = YFScreenW - 2 * YFTopicMargin;
        CGFloat h = w * self.height /self.width;
        if(h > 600) {
            h = 600;
            self.BigPicture = YES;
        };
        CGFloat x = YFTopicMargin;
        CGFloat y = labelH + 70 + YFTopicMargin;
        
        _pictureF = CGRectMake(x, y , w , h);
        
        if(self.type == topicsTypePicture || self.type == topicsTypeVoice || self.type == topicsTypeVideo){
            _cellHeight += h + YFTopicMargin;
        }
        
        
        if(self.top_cmt.count){
            
            CGFloat topcomment = 20;
            YFComment *comment = self.top_cmt[0];
            CGFloat contentH = [[NSString stringWithFormat:@"%@ : %@",comment.user.username,comment.content ] boundingRectWithSize:CGSizeMake(YFScreenW - YFTopicMargin *2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17] }context:nil].size.height;
            _commentViewH = topcomment + YFTopicMargin + contentH + 10;
            
            
            
            _cellHeight += _commentViewH + YFTopicMargin;
        }
        
        
        _cellHeight += 35+YFTopicMargin ;
    }
    return _cellHeight;
}

-(void)setTop_cmt:(NSArray *)top_cmt
{
    _top_cmt = [YFComment mj_objectArrayWithKeyValuesArray:top_cmt];
    
}

//-(NSMutableDictionary *)mj_keyValuesWithKeys:(NSArray *)keys
//{
//    return
//}
@end
