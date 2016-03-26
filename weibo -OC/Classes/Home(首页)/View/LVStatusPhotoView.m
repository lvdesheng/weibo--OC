//
//  LVStatusPhotoView.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/16.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVStatusPhotoView.h"
#import <UIImageView+WebCache.h>
#import "LVPhoto.h"
@implementation LVStatusPhotoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        //超出边框的内容减掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhoto:(LVPhoto *)photo
{
    _photo = photo;
    
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}


@end
