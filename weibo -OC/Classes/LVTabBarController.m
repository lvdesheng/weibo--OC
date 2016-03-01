//
//  LVTabBarController.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/1.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVTabBarController.h"
#import "LVHomeViewController.h"
#import "LVDiscoverViewController.h"
#import "LVMeViewController.h"
#import "LVMessageViewController.h"
#import "LVVNavgationController.h"



@interface LVTabBarController ()

@end

@implementation LVTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    

}


- (void)addChildController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage
{
    //设置tabBar的图片
    childVC.title = title;// 同时设置tabbar和navigationBar的文字
//    childVC.tabBarItem.title = title;
    
    
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
    
    
    //设置子控制器
    LVVNavgationController *navVC = [[LVVNavgationController alloc]initWithRootViewController:childVC];
    
    [self addChildViewController:navVC];
}

@end
