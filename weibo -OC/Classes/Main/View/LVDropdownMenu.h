//
//  LVDropdownMenu.h
//  weibo -OC
//
//  Created by lvdesheng on 16/3/2.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LVDropdownMenu : UIView

+ (instancetype)menu;


//显示
- (void)showFrom:(UIView *)from;

/**
 *  销毁
 */
- (void)dismiss;


/**内容*/
@property (nonatomic, strong) UIView *content;

/**内容控制器*/
@property (nonatomic, strong) UIViewController *contentContrller;

@end
