//
//  LVStatusPhotosView.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/16.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVStatusPhotosView.h"
#import "UIImageView+WebCache.h"
#import "LVPhoto.h"
#import "LVStatusPhotoView.h"
#define LVStatusPhotoMaxCol(count) ((count==4)?2:3)
#define LVStatusPhotoWH 80
#define LVStatusPhotoMargin 15


@implementation LVStatusPhotosView //9


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    int photosCount = photos.count;
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        LVStatusPhotoView *photoView = [[LVStatusPhotoView alloc]init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0 ; i < self.subviews.count; i++) {
        LVStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount){//显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        }else{//隐藏
            photoView.hidden = YES;
        }
        
    }
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片位置和尺寸
    int photosCount = self.photos.count;
    int maxCol = LVStatusPhotoMaxCol(photosCount);
    for (int i = 0; i < photosCount; i++) {
        
        LVStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (LVStatusPhotoWH + LVStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (LVStatusPhotoWH  + LVStatusPhotoMargin);
        photoView.width = LVStatusPhotoWH;
        photoView.height = LVStatusPhotoWH;

    }
    
    
    
}

+ (CGSize)sizeWithCount:(int)conut{
    
    //最大列数(一行最多多少列)
    int maxCols = LVStatusPhotoMaxCol(conut);
    
    int cols = (conut >= maxCols) ? maxCols : conut;
    
    CGFloat photosW = cols * LVStatusPhotoWH + (cols - 1) * LVStatusPhotoMargin;
    
    //公式
    int rows = (conut + maxCols - 1) / maxCols;
    CGFloat photoH = rows * LVStatusPhotoWH + (cols - 1) * LVStatusPhotoMargin;

    
    return CGSizeMake(photosW, photoH);
}

















@end
