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
#import "LVFooter.h"
#import "LVStatusCell.h"
#import "LVStatusFrame.h"




@interface LVHomeViewController ()<LVDropdownMenuDelegate>

/**
 *  微博数组（里面放的都是LVStatusFrame模型，一个LVStatusFrame对象就代表一条微博）
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation LVHomeViewController

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [[NSMutableArray alloc] init];
        
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = LVColor(211, 211, 211);
    
    //设置导航栏内容
    [self setupNavigationBar];
    
    //获取用户信息
    [self setupUserInfo];
    
    
    //集成下拉刷新控件
    [self setupDownRefresh];
    
    //集成上拉加载控件
    [self setupUpRefresh];
    
    
    //获得未读数
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadcount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
}
/**
 *  获得未读数
 */
- (void)setupUnreadcount
{
//    LVFunc
    //请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //参数
    LVAcount *account = [LVAccountTool account];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"uid"] = account.uid;
    parameter[@"access_token"] = account.access_token;
    //发送请求
    
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        // 设置提醒数字(微博的未读数)
         // NSNumber --> NSString
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]){//如果是0 清空
            
            self.tabBarItem.badgeValue = nil;
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{//非0的情况
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LVLog(@"%@",error);
    }];
}


/**
 *  集成上拉加载控件
 */
- (void)setupUpRefresh
{
    LVFooter *footer = [LVFooter footer];
    
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

/**
 *  集成下拉刷新控件
 */
- (void)setupDownRefresh
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
     // 只有用户通过手动下拉刷新，才会触发UIControlEventValueChanged事件
    [refreshControl addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    
     [self.tableView addSubview:refreshControl];
    // 2.马上进入刷新状态(仅仅是显示刷新状态，并不会触发UIControlEventValueChanged事件)
    [refreshControl beginRefreshing];
    //马上加载数据
    [self loadNewStatus:refreshControl];
}

/**
 *  将LVStatus模型转为LVStatusFrame模型
 */
- (NSArray *)statusFramesWithStaus:(NSArray *)statuses
{
    NSMutableArray *fames = [NSMutableArray array];
    
    for (LVStatus *status in statuses) {
        LVStatusFrame *f = [[LVStatusFrame alloc]init];
        f.status = status;
        [fames addObject:f];
    }
    return fames;
}




/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
- (void)loadNewStatus:(UIRefreshControl *)refreshControl
{
    //请求管理者
    AFHTTPSessionManager *mgr =  [AFHTTPSessionManager manager];
    //网络参数
    LVAcount *account = [LVAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;

    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    LVStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF){
        //since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        parameters[@"since_id"] = firstStatusF.status.idstr;
    }
    
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        // 将 "微博字典"数组 转为 "微博模型"数组
        
        NSArray *newStauses = [LVStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];

        // 将 LVStatus数组 转为 LVStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStaus:newStauses];
        
        // 将最新的微博数据，添加到总数组的最前面
        
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [refreshControl endRefreshing];
        
        //显示最新微博数量
        [self showNewStatusCount:newStauses.count];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LVLog(@"请求微博数据失败 - %@",error);
        //结束刷新
        [refreshControl endRefreshing];
    }];


}

/**
 *  上拉加载更多数据
 */
- (void)loadMoreStatus
{
    //会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //拼接参数
    LVAcount *account = [LVAccountTool account];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    LVStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF){
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long MaxId = lastStatusF.status.idstr.longLongValue - 1;
        parameter[@"max_id"] = @(MaxId);
    }
    
    
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStauses = [LVStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将 LVStatus数组 转为 LVStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStaus:newStauses];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        //刷新课表
        [self.tableView reloadData];
        
        //结束刷新隐藏footer
        self.tableView.tableFooterView.hidden = YES;
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LVLog(@"请求微博数据失败 - %@",error);
        //结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
    
}
/**
 *  显示最新微博数量
 *
 *  @param conut 最新微博数量
 */
- (void)showNewStatusCount:(NSInteger)conut
{
    //刷新成功清空图片数字
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //1.创建label
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = LVScreenW;
    label.height = 35;
    //2.其他属性
    
    if (conut == 0){
        label.text = @"没有新的微博";
    }else{
        label.text = [NSString stringWithFormat:@"共有%ld条新微薄",conut];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    
    //3.添加
    label.y = 64 - label.height;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    ;
    //4.动画
    // 先利用1s的时间，让label往下移动一段距离
    NSTimeInterval Duration = 1.0;
    [UIView animateWithDuration:Duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    }completion:^(BOOL finished) {
        // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        
        NSTimeInterval delay = 1.0;
        // UIViewAnimationOptionCurveLinear:匀速
        [UIView animateWithDuration:Duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
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
    return  self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //获得cell
    LVStatusCell *cell = [LVStatusCell cellWithTabelView:tableView];
    
    //给cell传递frame数据
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;

}

#pragma mark - tableView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offSetY >= judgeOffsetY){
        //显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        //加载更多数据
        [self loadMoreStatus];
    }
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LVStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}



@end