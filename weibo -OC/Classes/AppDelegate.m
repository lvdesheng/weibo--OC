//
//  AppDelegate.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/1.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "AppDelegate.h"
#import "LVHomeViewController.h"
#import "LVDiscoverViewController.h"
#import "LVMeViewController.h"
#import "LVMessageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置根控制器
    
    UITabBarController *tabBarVC = [[UITabBarController alloc]init];

    self.window.rootViewController = tabBarVC;

    
    [self.window makeKeyAndVisible];
    
    //设置子控制器
    
    //首页
    LVHomeViewController *homeVC = [[LVHomeViewController alloc]init];
    [self addChildController:homeVC title:@"首页" image:@"tabbar_home" selImage:@"tabbar_home_selected"];
    //消息
    LVMessageViewController *MessageVC = [[LVMessageViewController alloc]init];
    [self addChildController:MessageVC title:@"消息" image:@"tabbar_message_center" selImage:@"tabbar_message_center"];
    //发现
    LVDiscoverViewController *discoverVC = [[LVDiscoverViewController alloc]init];
    [self addChildController:discoverVC title:@"发现" image:@"tabbar_discover" selImage:@"tabbar_discover_selected"];
    //我
    LVMeViewController *meVC = [[LVMeViewController alloc]init];
    [self addChildController:meVC title:@"我" image:@"tabbar_profile" selImage:@"tabbar_profile_selected"];
    
    [tabBarVC addChildViewController:homeVC];
    [tabBarVC addChildViewController:MessageVC];
    [tabBarVC addChildViewController:discoverVC];
    [tabBarVC addChildViewController:meVC];
    
    return YES;
}


- (void)addChildController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage
{
    //设置tabBar的图片

    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [UIImage imageWithRenderingName:selImage];
    //字体颜色
    NSMutableDictionary *TextAttr = [NSMutableDictionary dictionary];
    TextAttr[NSForegroundColorAttributeName] = LVColor(123, 123, 123);
    
    [childVC.tabBarItem setTitleTextAttributes:TextAttr forState:UIControlStateNormal];
    
    NSMutableDictionary *selTextAttr = [NSMutableDictionary dictionary];
    selTextAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:selTextAttr forState:UIControlStateSelected];
    
    childVC.view.backgroundColor = LVRandomColor;
    

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
