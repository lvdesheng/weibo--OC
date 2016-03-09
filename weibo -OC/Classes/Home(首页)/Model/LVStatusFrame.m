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
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    CGFloat originalH = CGRectGetMaxY(self.contentLabelF) + LVStatusCellBorderW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    self.cellHeight = CGRectGetMaxY(self.originalViewF);
    
}

@end
