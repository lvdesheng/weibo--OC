//
//  LVHomeViewController.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/1.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVHomeViewController.h"




@interface LVHomeViewController ()

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
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)buttonClick
{
     // 这样获得的窗口，是目前显示在屏幕最上面的窗口
    // self.view.window = [UIApplication sharedApplication].keyWindow
    // 建议使用[UIApplication sharedApplication].keyWindow获得窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //添加蒙版(用来拦截灰色以外的点击事件)
    UIView *cover = [[UIView alloc]init];
    cover.backgroundColor = [UIColor clearColor];
    cover.frame = window.frame;
    [window addSubview:cover];
    
    //添加带箭头的灰色图片
    UIImageView *dropdownMenu = [[UIImageView alloc]init];
    dropdownMenu.image = [UIImage imageNamed:@"popover_background"];
    dropdownMenu.width = 217;
    dropdownMenu.height = 217;
    dropdownMenu.y = 40;
    
    [dropdownMenu addSubview:[UIButton buttonWithType:UIButtonTypeInfoLight]];
    [window addSubview:dropdownMenu];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
