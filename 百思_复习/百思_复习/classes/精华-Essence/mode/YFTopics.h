//
//  YFTopics.h
//  百思_复习
//
//  Created by 钟永发 on 16/7/19.
//  Copyright © 2016年 facker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFTopics : NSObject
/** name */
@property(nonatomic,strong)NSString *screen_name;
/** 头像 */
@property(nonatomic,strong)NSString *profile_image;

/** 踩得数量 */
@property(nonatomic,strong)NSString *cai;
/** 顶的数量 */
@property(nonatomic,strong)NSString *ding;
/** 转发的数量 */
@property(nonatomic,strong)NSString *repost;
/** 帖子内容 */
@property(nonatomic,strong)NSString *text;
/** 评论的数量 */
@property(nonatomic,strong)NSString *comment;
/** 是否是百思会员 */
@property(nonatomic,strong)NSString* jie_v;
/** 是否是新浪会员 */
@property(nonatomic,assign)NSInteger sina_v;
/** 发帖时间 */
@property(nonatomic,strong)NSString *passtime;
/** 帖子的类型 */
@property(nonatomic,assign) topicsType type;

/** 是否是动画 */
@property(nonatomic,assign)BOOL isgif;
/** 视频或图片的宽度 */
@property(nonatomic,assign)CGFloat width;
/** 视频或图片的高度 */
@property(nonatomic,assign)CGFloat height;
/** 图片（大） */
@property(nonatomic,strong)NSString *image2;
/** 图片（中） */
@property(nonatomic,strong)NSString *image1;
/** 图片（小） */
@property(nonatomic,strong)NSString *image0;

//最热评论数组
@property(nonatomic,strong)NSArray *top_cmt;
/** 视频url */
@property(nonatomic,strong)NSString *videouri;

/** 帖子的id */
@property(nonatomic,strong)NSString *id;


//额外辅助属性
/** cell的高度 */
@property(nonatomic,assign)CGFloat cellHeight;

/** 图片的尺寸 */
@property(nonatomic,assign)CGRect pictureF;
/** 是否是大图片 */
@property(nonatomic,assign)BOOL BigPicture;
/** 评论的高度 */
@property(nonatomic,assign)CGFloat commentViewH;

@end
