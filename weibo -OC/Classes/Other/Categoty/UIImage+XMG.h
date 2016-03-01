//
//  UIImage+XMG.h
//  小码哥彩票
//
//  Created by xiaomage on 16/1/4.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XMG)
/**
 *  图片不要渲染
 *
 *  @param name 图片名字
 *
 *  @return 不要渲染的图片
 */
+ (UIImage *)imageWithRenderingName:(NSString *)name;
// 拉伸图片
+ (UIImage *)stretchableImageWithName:(NSString *)name;
@end
