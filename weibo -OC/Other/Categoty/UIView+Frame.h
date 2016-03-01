//
//  UIView+Frame.h
//  BuDeJie
//
//  Created by xiaomage on 16/2/19.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
// @property : 只会生成get,set方法声明,不会生成get,set方法实现,和下划线成员属性
@interface UIView (Frame)

@property CGFloat width;
@property CGFloat height;

@property CGFloat x;
@property CGFloat y;

@property CGFloat centerX;
@property CGFloat centerY;

@end
