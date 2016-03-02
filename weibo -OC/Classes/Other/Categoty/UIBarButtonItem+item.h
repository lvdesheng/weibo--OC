//
//  UIBarButtonItem+item.h
//  BSBDJ
//
//  Created by lvdesheng on 16/2/19.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+ImageTitleSpacing.h"

@interface UIBarButtonItem (item)


/**
 *  创建一个navigationItem 高亮
 *
 *  @param image     非高亮图片
 *  @param highimage 高亮图片
 *  @param target    监听者
 *  @param action    监听者调用方法
 *
 *  @return 返回一个item
 */
+ (UIBarButtonItem *)itemWithImage: (UIImage *)image highImage: (UIImage *)highimage addTarget:(id)target action:(SEL)action;

/**
 *  创建一个navigationItem 选中
 *
 *  @param image    图片
 *  @param selimage 选中图片
 *  @param target   监听者
 *  @param action   调用方法
 *
 *  @return 返回一个item
 */
+ (UIBarButtonItem *)itemWithImage: (UIImage *)image selImage: (UIImage *)selimage addTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithImage: (UIImage *)image highImage: (UIImage *)highimage addTarget:(id)target action:(SEL)action title:(NSString *)title;


/**
 *  此方法可以设置item里面的image和title的相对位置
 */
+ (UIBarButtonItem *)leftItemWithImage: (UIImage *)image highImage: (UIImage *)highimage addTarget:(id)target action:(SEL)action title:(NSString *)title space:(CGFloat)space fontOfSize:(CGFloat)fontOfSize MKButtonEdgeInsetsStyle:(MKButtonEdgeInsetsStyle )style;

/**
 *  此方法可以设置item里面的image和title的相对位置
 */
+ (UIBarButtonItem *)rightItemWithImage: (UIImage *)image highImage: (UIImage *)highimage addTarget:(id)target action:(SEL)action title:(NSString *)title space:(CGFloat)space fontOfSize:(CGFloat)fontOfSize MKButtonEdgeInsetsStyle:(MKButtonEdgeInsetsStyle )style;
@end
