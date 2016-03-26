//
//  LVStatusPhotosView.h
//  weibo -OC
//
//  Created by lvdesheng on 16/3/16.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//  cell上面的配图相册（里面会显示1~9张图片, 里面都是HWStatusPhotoView）

#import <UIKit/UIKit.h>
@class LVPhoto;

@interface LVStatusPhotosView : UIView


@property (nonatomic, strong)   NSArray *photos;

/**
 *  根据个数计算相册尺寸
 *
 */
+ (CGSize)sizeWithCount: (int)conut;

@end
