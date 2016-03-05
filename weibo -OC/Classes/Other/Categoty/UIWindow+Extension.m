//
//  UIWindow+Extension.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/5.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "LVTabBarController.h"
#import "LVNewFeatureController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController
{
    //设置启动逻辑
    NSString *key = @"CFBundleVersion";
    //上一次使用的版本号(存在沙盒)
    NSString *lastVersion =  [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //当前版本号(从info.plist中获取)
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]){//版本号相同,这次打开的和上次打开的相同
        self.rootViewController = [[LVTabBarController alloc]init];
    }else{//和上次打开的不一样
        self.rootViewController = [[LVNewFeatureController alloc]init];
        
        //将当前版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //刷新
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

}

@end
