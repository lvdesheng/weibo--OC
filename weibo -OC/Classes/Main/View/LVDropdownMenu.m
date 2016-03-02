//
//  LVDropdownMenu.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/2.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVDropdownMenu.h"

@interface LVDropdownMenu ()

/**
 *  将来显示具体内容的容器
 */
@property (nonatomic, weak)  UIImageView *containerView;

@end

@implementation LVDropdownMenu

//懒加载
- (UIImageView *)containerView
{
    if (!_containerView) {
        //添加灰色图片控件
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.width = 217;
        containerView.height = 217;
        containerView.userInteractionEnabled = YES;//开启交互
        [self addSubview:containerView];
        
        self.containerView = containerView;
    }
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //清楚颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc] init];
}

- (void)setContent:(UIView *)content
{
    _content = content;
    
    //调整内容位置
    content.x = 10;
    content.y = 15;
    
    //调整内容宽度
    content.width = self.containerView.width - 2 *content.x;
    
    //设置灰色高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    
    //添加内容到灰色图片中
    [self.containerView addSubview:content];
}

- (void)setContentContrller:(UIViewController *)contentContrller
{
    _contentContrller = contentContrller;
    
    self.content = contentContrller.view;

}

/**
 *  显示
 */
- (void)showFrom:(UIView *)from
{
    //获得最上面窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //添加自己到窗口
    [window addSubview:self];
    
    //设置尺寸
    self.frame = window.bounds;
    
    //调整灰色图片位置
    self.containerView.x = (self.width - self.containerView.width) * 0.5;
    self.containerView.y = 50;
    
    
    //通知外接,自己显示
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)])
    {
        [self.delegate dropdownMenuDidShow:self];
    }
}


/**
 *  销毁
 */

- (void)dismiss
{
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)])
    {
        [self.delegate dropdownMenuDidShow:self];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self dismiss];
}

@end
