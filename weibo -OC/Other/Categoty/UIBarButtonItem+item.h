//
//  UIBarButtonItem+item.h
//  BSBDJ
//
//  Created by lvdesheng on 16/2/19.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

+ (UIBarButtonItem *)itemWithImage: (UIImage *)image highImage: (UIImage *)highimage addTarget:(id)target action:(SEL)action;


+ (UIBarButtonItem *)itemWithImage: (UIImage *)image selImage: (UIImage *)selimage addTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithImage: (UIImage *)image highImage: (UIImage *)highimage addTarget:(id)target action:(SEL)action title:(NSString *)title;
@end
