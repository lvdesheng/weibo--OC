//
//  LVStatusFrame.h
//  weibo -OC
//
//  Created by lvdesheng on 16/3/9.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <Foundation/Foundation.h>

// 昵称字体
#define LVStatusCellNameFont [UIFont systemFontOfSize:17]
// 时间字体
#define LVStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define LVStatusCellSourceFont LVStatusCellTimeFont
// 正文字体
#define LVStatusCellContentFont [UIFont systemFontOfSize:16]


@class LVStatus;

@interface LVStatusFrame : NSObject


@property (nonatomic, strong) LVStatus *status;

/**原创微博整体*/
@property (nonatomic, assign)  CGRect originalViewF;
/**头像*/
@property (nonatomic, assign)  CGRect iconViewF;
/**会员图标*/
@property (nonatomic, assign)  CGRect vipViewF;
/**配图*/
@property (nonatomic, assign)  CGRect photoViewF;
/**昵称*/
@property (nonatomic, assign)  CGRect  nameLabelF;
/**时间*/
@property (nonatomic, assign)  CGRect  timeLabelF;
/**来源*/
@property (nonatomic, assign)  CGRect  sourceLabelF;
/**正文*/
@property (nonatomic, assign)  CGRect  contentLabelF;

/**cell的高度*/
@property (nonatomic, assign)  CGFloat cellHeight;

@end
