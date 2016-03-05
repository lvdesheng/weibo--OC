//
//  LVHomeViewController.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/1.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVHomeViewController.h"
#import "LVTitleMenuViewController.h"
#import "LVDropdownMenu.h"
#import "AFNetworking.h"





@interface LVHomeViewController ()<LVDropdownMenuDelegate>

@end

@implementation LVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏的上面内容
   
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] addTarget:self action:@selector(friendAdd) title:@"加好友" space:0 fontOfSize:10 MKButtonEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop];
    
    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] addTarget:self action:@selector(pop)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] addTarget:self action:@selector(pop) title:@"扫一扫" space:0 fontOfSize:10 MKButtonEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop];

    
    /*中间标题按钮*/
    UIButton *button = [[UIButton alloc]init];
    button.width = 150;
    button.height = 30;
//    button.backgroundColor = LVRandomColor;
    
    //设置图片和文字
    [button setTitle:@"首页" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    
    //button的图片和title调换位置
    CGFloat space = 2;
    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:space];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = button;
    

    
}


- (void)friendAdd
{
    LVFunc
}

- (void)pop
{
    LVFunc
}

- (void)buttonClick:(UIButton *)button
{
    //创建下拉菜单
    LVDropdownMenu *menu = [LVDropdownMenu menu];
    menu.delegate = self;
    //设置内容
    LVTitleMenuViewController *menuVC = [[LVTitleMenuViewController alloc]init];
    menuVC.view.height = 40 * 4;
    menu.contentContrller = menuVC;
    
    //显示
    [menu showFrom:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - LVDropdownMenuDelegate
/**
 *  下拉菜单显示
 *
 *  @param Menu menu
 */
- (void)dropdownMenuDidShow:(LVDropdownMenu *)Menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
}
/**
 *  下拉菜单销毁
 *
 *  @param Menu Menu
 */
- (void)dropdownMenuDidDismiss:(LVDropdownMenu *)Menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;

}

@end