//
//  AppDelegate.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/1.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "AppDelegate.h"
#import "LVTabBarController.h"
#import "LVNewFeatureController.h"
#import "LVOAuthController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置根控制器
    
    LVOAuthController *OAuthController = [[LVOAuthController alloc]init];

    self.window.rootViewController = OAuthController;
    
//    //设置启动逻辑
//    NSString *key = @"CFBundleVersion";
//    //上一次使用的版本号(存在沙盒)
//    NSString *lastVersion =  [[NSUserDefaults standardUserDefaults] objectForKey:key];
//    //当前版本号(从info.plist中获取)
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
//    
//    if ([currentVersion isEqualToString:lastVersion]){//版本号相同,这次打开的和上次打开的相同
//        self.window.rootViewController = [[LVTabBarController alloc]init];
//    }else{//和上次打开的不一样
//        self.window.rootViewController = [[LVNewFeatureController alloc]init];
//    
//        //将当前版本号存入沙盒
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
//        //刷新
//        [[NSUserDefaults standardUserDefaults]synchronize];
//    }
    

    
    [self.window makeKeyAndVisible];
    

    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
