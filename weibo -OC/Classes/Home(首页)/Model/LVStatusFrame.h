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

// 被转发微博的正文字体
#define LVStatusCellRetweetContentFont [UIFont systemFontOfSize:15]

// cell之间的间距
#define LVStatusCellMargin 15

// cell的边框宽度
#define LVStatusCellBorderW 5

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

/**转发微博整体*/
@property (nonatomic, assign) CGRect retweetViewF;

/**转发微博正文 + 昵称*/
@property (nonatomic, assign) CGRect retweetContentLabelF;

/**转发配图*/
@property (nonatomic, assign) CGRect retweetPhotoViewF;

/**底部工具条*/
@property (nonatomic, assign)CGRect toolBarF;


@end
