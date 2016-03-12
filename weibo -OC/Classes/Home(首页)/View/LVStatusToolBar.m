//
//  LVStatusToolBar.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/12.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVStatusToolBar.h"

@interface LVStatusToolBar ()


/**里面放所有Btn*/
@property (nonatomic, strong) NSMutableArray *btns;

/**里面放所有分割线*/
@property (nonatomic, strong) NSMutableArray *drivers;

/**评论按钮*/
@property (nonatomic, weak)  UIButton *repostsBtn;
/**转发按钮*/
@property (nonatomic, weak)  UIButton *commentsBtn;
/**点赞按钮*/
@property (nonatomic, weak)  UIButton *attitudesBtn;

@end

@implementation LVStatusToolBar

//懒加载
- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [[NSMutableArray alloc] init];
        
    }
    return _btns;
}


- (NSMutableArray *)drivers
{
    if (!_drivers) {
        _drivers = [[NSMutableArray alloc] init];
        
    }
    return _drivers;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        //添加按钮
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"转发" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
        
        self.repostsBtn = btn;
        [self addSubview:btn];
        [self.btns addObject:btn];

        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.repostsBtn.frame = CGRectMake(0, 0, 35, self.height);
    
    
}

- (void)setStatus:(LVStatus *)status
{
    _status = status;
    

    
}

@end
