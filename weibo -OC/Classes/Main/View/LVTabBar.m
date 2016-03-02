//
//  LVTabBar.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/2.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVTabBar.h"

@interface LVTabBar ()


@property (nonatomic, weak)  UIButton *plusBtn;

@end

@implementation LVTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加一个按钮到tabBar中
        UIButton *plusBtn = [[UIButton alloc]init];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}
/**
 *  按钮点击
 */
- (void)plusBtnClick
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)])
    {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    

    //设置加号按钮位置
    self.plusBtn.centerX = LVScreenW * 0.5;
    self.plusBtn.centerY = self.height * 0.5;

    //设置其他tabBar按钮的尺寸
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class])
        {
            //设置宽度
            child.width = tabBarButtonW;
            //设置X
            child.x = tabBarButtonIndex * tabBarButtonW;
            
            //增加索引
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2)
            {
                tabBarButtonIndex++;
            }
        }
    }
    
}

@end
