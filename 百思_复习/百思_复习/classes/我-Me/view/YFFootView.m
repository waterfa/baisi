//
//  YFFootView.m
//  百思_复习
//
//  Created by 钟永发 on 16/7/21.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "YFFootView.h"
#import <AFNetworking.h>
#import "YFMeBtnMode.h"
#import <MJExtension.h>
#import <UIButton+WebCache.h>
#import "YFMeBtnMode.h"
#import "YFFootBtn.h"
@interface YFFootView ()

/** 存放模型的数组 */
@property(nonatomic,strong)NSArray *modes;

@end


@implementation YFFootView
static BOOL add = YES;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   if(self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier])
   {
       ;
   }
    
    return self;
}

-(void)setup
{
    self.backgroundColor = [UIColor clearColor];
    [self setupRequest];
    
}


//发送请求
-(void)setupRequest
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        self.modes = [YFMeBtnMode mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        [self setBtn];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"加载失败");
    }];
    
    
    
}

-(void)setBtn
{
    NSInteger count = self.modes.count;
    
    for(int i = 0;i<count;i++)
    {
        YFMeBtnMode *mode = self.modes[i];
        
        YFFootBtn *btn = [YFFootBtn buttonWithType:UIButtonTypeCustom];
        btn.mode = mode;
        
        int cols = 4;
        //列
        int col = i %cols;
        //行
        int row = i /cols;
        
        CGFloat w = YFScreenW / cols;
        CGFloat h = w ;
        CGFloat x =  col * w;
        
        CGFloat y = row * h ;
        
        btn.frame  = CGRectMake(x, y , w , h );
        
        [self addSubview:btn];
        
//        btn.hidden = YES;
        
        
        if(i == count - 1){
//            btn.hidden = NO;
            self.maxheight = CGRectGetMaxY(btn.frame) + 10;
            
        }
    }
}

-(void)setMaxheight:(CGFloat)maxheight
{
    _maxheight = maxheight;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"height"] = @(maxheight);
    
    if(add){
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fuck" object:nil userInfo:dict];
        add = NO;
    }
}


-(void)setFootView:(BOOL)footView
{
    _footView = footView;
    
    
    
    [self setup];
}


-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}
@end
