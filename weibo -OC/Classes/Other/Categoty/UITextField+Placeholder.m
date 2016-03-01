//
//  UITextField+Placeholder.m
//  BuDeJie
//
//  Created by xiaomage on 16/2/22.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>

@implementation UITextField (Placeholder)

+ (void)load
{
    // setPlaceholder
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    // xmg_setPlaceholder
    Method xmg_setPlaceholderMethod = class_getInstanceMethod(self, @selector(xmg_setPlaceholder:));
    
    // 交换方法实现
    method_exchangeImplementations(setPlaceholderMethod, xmg_setPlaceholderMethod);
}

// 设置占位文字颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 保存占位文字颜色:动态添加属性 => runtime
    // 1.给哪个对象保存属性
    // 2.属性名称
    // 3.属性值
    // 4.属性策略
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 真正设置占位文字颜色
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

// 设置占位文字并且设置占位文字颜色
- (void)xmg_setPlaceholder:(NSString *)placeholder
{
    //  设置占位文字
    [self xmg_setPlaceholder:placeholder];
    
    // 设置占位文字颜色
    [self setPlaceholderColor:self.placeholderColor];
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

@end
