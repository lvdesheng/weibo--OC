//
//  LVVNavgationController.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/1.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVVNavgationController.h"

@interface LVVNavgationController ()

@end

@implementation LVVNavgationController

+ (void)initialize
{
    //设置整个项目的item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //普通状态
    
    NSMutableDictionary *TextAttr = [NSMutableDictionary dictionary];
    TextAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    TextAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:TextAttr forState:UIControlStateNormal];
    //不可用状态
    NSMutableDictionary *disableTextAttr = [NSMutableDictionary dictionary];
    disableTextAttr[NSForegroundColorAttributeName] = LVColor(147, 147, 147);
    disableTextAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:disableTextAttr forState:UIControlStateDisabled];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count > 0)
    {// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）

        //自动显示和隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        /**************设置导航栏上的内容*******************************/
        //返回
        UIButton *backBtn = [[UIButton alloc] init];
        //设置图片
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        
        //设置尺寸
        backBtn.size = backBtn.currentImage.size;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        
        //更多
        UIButton *moreBtn = [[UIButton alloc] init];
        //设置图片
        [moreBtn setImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        
        //设置尺寸
        moreBtn.size = moreBtn.currentImage.size;
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
        
        
        /**************设置导航栏上的内容*******************************/
    }
    
    
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)backClick
{
#warning 这里要用self，不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

- (void)moreClick
{
    [self popViewControllerAnimated:YES];
}

@end
