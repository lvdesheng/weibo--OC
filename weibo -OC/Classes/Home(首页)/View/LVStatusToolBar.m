//
//  LVStatusToolBar.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/12.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVStatusToolBar.h"
#import "LVStatus.h"

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
       self.btns = [NSMutableArray array];
        
    }
    return _btns;
}


- (NSMutableArray *)drivers
{
    if (!_drivers) {
        self.drivers = [NSMutableArray array];
        
    }
    return _drivers;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        //添加
        self.repostsBtn = [self setupBtn:@"转发" imageName:@"timeline_icon_retweet"];
        self.commentsBtn = [self setupBtn:@"评论" imageName:@"timeline_icon_comment"];
        self.attitudesBtn = [self setupBtn:@"赞" imageName:@"timeline_icon_unlike"];

        //添加分割线 两次
        [self setupDriver];
        [self setupDriver];
    }
    return self;
}

/**
 *  添加分割线
 */
- (void)setupDriver
{
    UIImageView *driver = [[UIImageView alloc]init];
    driver.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self.drivers addObject:driver];
    [self addSubview:driver];
}


/**
 *  初始化一个按钮
 *
 */
- (UIButton *)setupBtn:(NSString *)title imageName:(NSString *)imageName
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    return btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    //设置按钮frame
    NSUInteger count = self.btns.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.btns[i];
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        btn.x = btnW * i;
    }
    
    // 设置分割线的frame
    NSUInteger drivercount = self.drivers.count;
    for (NSUInteger i = 0; i < drivercount; i++) {
        UIImageView *driver =  self.drivers[i];
        driver.width  = 1;
        driver.height = btnH;
        driver.x = (i + 1) * btnW;
        driver.y = 0;
    }
    
    
    
}

- (void)setStatus:(LVStatus *)status
{
    _status = status;
    
//    [self.repostsBtn setTitle:@"转发" forState:UIControlStateNormal];
    // 转发
    [self setupBtnCount:status.reposts_count btn:self.repostsBtn title:@"转发"];
    // 评论
    [self setupBtnCount:status.comments_count btn:self.commentsBtn title:@"评论"];
    // 赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudesBtn title:@"赞"];
    
}


- (void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) { // 数字不为0
        if (count < 10000) { // 不足10000：直接显示数字，比如786、7986
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 达到10000：显示xx.x万，不要有.0的情况
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
