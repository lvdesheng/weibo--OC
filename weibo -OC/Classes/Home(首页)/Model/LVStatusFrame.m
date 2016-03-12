//
//  LVStatusFrame.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/9.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVStatusFrame.h"
#import "LVUser.h"
#import "LVStatus.h"

// cell的边框宽度
#define LVStatusCellBorderW 10

@implementation LVStatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

- (void)setStatus:(LVStatus *)status
{
    _status = status;
    
    LVUser *user = status.user;
    
    //cell的宽度
    CGFloat cellW = LVScreenW;
    
    /*原创微博*/
    
    /**头像 */
    CGFloat iconWH = 35;
    CGFloat iconX = LVStatusCellBorderW;
    CGFloat iconY = LVStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /**昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + LVStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize  nameSize = [self sizeWithText:user.name font:LVStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY} ,nameSize};
    
    /** 会员图标 */
    if (user.vip){
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + LVStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /**时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + LVStatusCellBorderW;
    CGSize  timeSize = [self sizeWithText:status.created_at font:LVStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY} ,timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + LVStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:LVStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};

    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + LVStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [self sizeWithText:status.text font:LVStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /** 配图 */
    CGFloat originalH = 0;
    if (status.pic_urls.count){//有配图
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + LVStatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        
        originalH = CGRectGetMaxY(self.photoViewF) + LVStatusCellBorderW;
    }else{
        originalH = CGRectGetMaxY(self.contentLabelF) + LVStatusCellBorderW;
    }
  
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = LVStatusCellMargin;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat toolbarY = 0;
    /*被转发微博 */
    if (status.retweeted_status){
        LVStatus *retweeted_status = status.retweeted_status;
        LVUser *retweeted_status_user = retweeted_status.user;
        /** 被转发微博正文*/
        CGFloat retweetContentX = LVStatusCellBorderW;
        CGFloat retweetContentY = LVStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:LVStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF =(CGRect) {{retweetContentX,retweetContentY} ,retweetContentSize};
        
        
        /**被转发微博配图 */
        CGFloat retweetViewH = 0;
        if (retweeted_status.pic_urls.count){//转发微博有配图
            CGFloat retweetPhotoWH = 100;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoy = CGRectGetMaxY(self.retweetContentLabelF) + LVStatusCellBorderW;
            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoy, retweetPhotoWH, retweetPhotoWH);
            
            retweetViewH = CGRectGetMaxY(self.retweetPhotoViewF) +LVStatusCellBorderW;
        }else{//无配图
            retweetViewH = CGRectGetMaxY(self.retweetContentLabelF) +LVStatusCellBorderW;
        }
    
        /**被转发微博整体 */
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetViewW = cellW;
        self.retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);

        toolbarY = CGRectGetMaxY(self.retweetViewF);
        
    }else{
    
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    /**工具条 */
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 35;
    self.toolBarF = CGRectMake(toolBarX, toolbarY, toolBarW, toolBarH);
    
    /** cell高度*/
    self.cellHeight = CGRectGetMaxY(self.toolBarF);
    
}

@end
