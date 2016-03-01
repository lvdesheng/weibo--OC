//
//  UIImage+XMG.m
//  小码哥彩票
//
//  Created by xiaomage on 16/1/4.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UIImage+XMG.h"

@implementation UIImage (XMG)
+ (UIImage *)imageWithRenderingName:(NSString *)name{
    UIImage *image =  [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
+ (UIImage *)stretchableImageWithName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5f topCapHeight:image.size.height * 0.5f];
    return image;
}
@end
