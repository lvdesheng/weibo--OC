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
#import "LVAccountTool.h"
#import "LVTitleButton.h"


@interface LVHomeViewController ()<LVDropdownMenuDelegate>

@end

@implementation LVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setupNavigationBar];
    
    //获取用户信息
    [self setupUserInfo];
    

    
}



#pragma mark - 初始化
- (void)setupUserInfo
{
    /**
     https://api.weibo.com/2/users/show.json
     access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
     uid	false	int64	需要查询的用户ID。
     */
    
    //请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //拼接请求参数
    LVAcount *account = [LVAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;

    
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        //设置名字
        NSString *name = responseObject[@"name"];
        [titleButton setTitle:name forState:UIControlStateNormal];
        //存入沙盒
        account.name = name;
        [LVAccountTool saveAccount:account];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败-%@",error);
    }];

}
- (void)setupNavigationBar
{

    //设置导航栏的上面内容
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] addTarget:self action:@selector(friendAdd) title:@"加好友" space:0 fontOfSize:10 MKButtonEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop];
    
    
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] addTarget:self action:@selector(pop) title:@"扫一扫" space:0 fontOfSize:10 MKButtonEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop];
    
    
    /*中间标题按钮*/
    LVTitleButton *titlebutton = [[LVTitleButton alloc]init];

    //    button.backgroundColor = LVRandomColor;
    
    //设置图片和文字
    
    NSString *name = [LVAccountTool account].name;
    
    [titlebutton setTitle:name?name:@"首页" forState:UIControlStateNormal];

    [titlebutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titlebutton;
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