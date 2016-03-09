//
//  LVStatusCell.h
//  weibo -OC
//
//  Created by lvdesheng on 16/3/9.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LVStatusFrame;

@interface LVStatusCell : UITableViewCell


@property (nonatomic, strong) LVStatusFrame *statusFrame;

+ (instancetype)cellWithTabelView:(UITableView *)tabelView;

@end