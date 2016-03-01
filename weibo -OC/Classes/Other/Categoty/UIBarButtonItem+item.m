//
//  UIBarButtonItem+item.m
//  BSBDJ
//
//  Created by lvdesheng on 16/2/19.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)

+ (UIBarButtonItem *)itemWithImage: (UIImage *)image highImage: (UIImage *)highimage addTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highimage forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    
    [button addTarget:target action:(SEL)action forControlEvents:UIControlEventTouchUpInside];
    
    //包装到UIView
    
    UIView *contentView = [[UIView alloc] initWithFrame:button.bounds];
    
    [contentView addSubview:button];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
    
}



+ (UIBarButtonItem *)itemWithImage: (UIImage *)image selImage: (UIImage *)selimage addTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selimage forState:UIControlStateSelected];
    
    [button sizeToFit];
    
    [button addTarget:target action:(SEL)action forControlEvents:UIControlEventTouchUpInside];
    
    //包装到UIView
    
    UIView *contentView = [[UIView alloc] initWithFrame:button.bounds];
    
    [contentView addSubview:button];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
    
}

+ (UIBarButtonItem *)backItemWithImage: (UIImage *)image highImage: (UIImage *)highimage addTarget:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highimage forState:UIControlStateHighlighted];
    [backButton setTitle:title forState:UIControlStateNormal];
    
    // 设置按钮文字颜色
    
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [backButton sizeToFit];
    
    [backButton addTarget:target action:(SEL)action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置内容内边距
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    //包装到UIView
    
    UIView *contentView = [[UIView alloc] initWithFrame:backButton.bounds];
    
    [contentView addSubview:backButton];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
    
}



@end
