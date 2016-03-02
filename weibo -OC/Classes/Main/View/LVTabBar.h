//
//  LVTabBar.h
//  weibo -OC
//
//  Created by lvdesheng on 16/3/2.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LVTabBar;

#warning 因为HWTabBar继承自UITabBar，所以称为HWTabBar的代理，也必须实现UITabBar的代理协议
@protocol LVTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(LVTabBar *)tabBar;

@end

@interface LVTabBar : UITabBar
/**代理属性用weak*/
@property (nonatomic, weak)  id<LVTabBarDelegate> delegate;

@end
