 //
//  XMGAddTagToolbar.m
//  01-百思不得姐
//
//  Created by 钟永发 on 16/7/8.
//  Copyright © 2016年 facker. All rights reserved.
//

#import "XMGAddTagToolbar.h"
#import "XMGAddTagViewController.h"
@interface XMGAddTagToolbar ()
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 添加按钮 */
@property(nonatomic,weak)UIButton *addButton;

/** 存放所有标签label */
@property(nonatomic,strong)NSMutableArray *tagLabels;

@end
@implementation XMGAddTagToolbar
-(NSMutableArray *)tagLabels
{
    if(!_tagLabels)
    {
        _tagLabels = [NSMutableArray array];
        
    }
    return _tagLabels;
}


-(void)awakeFromNib
{
    
    //添加一个加号按钮
    UIButton *addButton = [[UIButton alloc]init];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
//    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = YFTagMargin;
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //默认拥有两个标签
    [self createTags:@[@"吐槽",@"糗事"]];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //更新标签按钮的frame
    for(int i = 0;i<self.tagLabels.count;i++)
    {
        UILabel *tagLabel = self.tagLabels[i];
        if(i==0){ //最前面的标签按钮
            tagLabel.x = 0;
            tagLabel.y = 0;
            
            
        }else{ //其他按钮
            UILabel *lastTagLabel = self.tagLabels[i-1];
            CGFloat leftwidth = CGRectGetMaxX(lastTagLabel.frame) + YFTagMargin;
            CGFloat rightwith = self.topView.width - leftwidth;
            
            if(rightwith >= tagLabel.width){
                //按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftwidth;
            }else { //换行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + YFTagMargin;
            }
        }
    }
    
    
    //更新addBtn的frame
    UILabel *lastLabel = [self.tagLabels lastObject];
    CGFloat leftwidth = CGRectGetMaxX(lastLabel.frame) + YFTagMargin ;
    CGFloat rightwidth = self.topView.width - leftwidth;
    
    if(rightwidth >= self.addButton.width){
        self.addButton.y = lastLabel.y;
        self.addButton.x = leftwidth;
    }else
    {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastLabel.frame)+ YFTagMargin;
    }
    
    
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.y -= self.height - oldH;
}

-(void)addButtonClick
{
    
    XMGAddTagViewController *vc = [[XMGAddTagViewController alloc]init];
    __weak typeof(self) weakself = self;
    [vc setTagsBlok:^(NSArray *tags){

        [weakself createTags:tags];
    }];
    vc.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:vc animated:YES];
    
    
   
}

//创建标签
-(void)createTags:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    

    for (int i = 0; i<tags.count; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor =  YFTagColor;
        label.textColor = [UIColor whiteColor];
        label.text = tags[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [label sizeToFit];
        label.width += 2 *YFTagMargin;
        label.height = YFTagH;
        
        
        
        [self.topView addSubview:label];
        [self.tagLabels addObject:label];
    }
    
    [self setNeedsLayout];
    
}
@end
