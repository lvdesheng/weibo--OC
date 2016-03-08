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
#import <UIImageView+WebCache.h>
#import "LVStatus.h"
#import "LVUser.h"
#import <MJExtension.h>


@interface LVHomeViewController ()<LVDropdownMenuDelegate>

/**微博数组（里面放的都是微博字典，一个字典对象就代表一条微博）*/
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation LVHomeViewController

- (NSMutableArray *)statuses
{
    if (!_statuses) {
        _statuses = [[NSMutableArray alloc] init];
        
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setupNavigationBar];
    
    //获取用户信息
    [self setupUserInfo];
    
    
    //集成刷新控件
    [self setupRefresh];
    
}

- (void)setupRefresh
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)refreshStateChange:(UIRefreshControl *)refreshControl
{
    //请求管理者
    AFHTTPSessionManager *mgr =  [AFHTTPSessionManager manager];
    //网络参数
    LVAcount *account = [LVAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    LVStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus){
        //since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        parameters[@"since_id"] = firstStatus.idstr;
    }
    
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        // 将 "微博字典"数组 转为 "微博模型"数组
        
        NSArray *newStauses = [LVStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        // 将最新的微博数据，添加到总数组的最前面
        
        NSRange range = NSMakeRange(0, newStauses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStauses atIndexes:set];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [refreshControl endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LVLog(@"请求微博数据失败 - %@",error);
        //结束刷新
        [refreshControl endRefreshing];
    }];


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
//        NSString *name = responseObject[@"name"];
        LVUser *user = [LVUser mj_objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        //存入沙盒
        account.name = user.name;
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
    LVTitleButton *button = [[LVTitleButton alloc]init];
    
    //设置图片和文字
    
    NSString *name = [LVAccountTool account].name;
    
    [button setTitle:name?name:@"首页" forState:UIControlStateNormal];
    

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
    LVTitleButton *titleButton = (LVTitleButton *)self.navigationItem.titleView;
    titleButton.selected = NO;

}
/**
 *  下拉菜单销毁
 *
 *  @param Menu Menu
 */
- (void)dropdownMenuDidDismiss:(LVDropdownMenu *)Menu
{
    LVTitleButton *titleButton = (LVTitleButton *)self.navigationItem.titleView;
    titleButton.selected = YES;

}

#pragma mark - tableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        static NSString *ID = @"statuses";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
    //取出对应行的的微博字典
    LVStatus *status = self.statuses[indexPath.row];
    
    //取出这条微博的作者
    
    LVUser *user = status.user;
    cell.textLabel.text = user.name;
    //设置微博文字
    cell.detailTextLabel.text = status.text;
    //设置头像
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
    
    return cell;

}

/**
 1.将字典转为模型
 2.能够下拉刷新最新的微博数据
 3.能够上拉加载更多的微博数据
 */

@end