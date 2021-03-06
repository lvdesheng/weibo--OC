//
//  LVTitleMenuViewController.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/2.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVTitleMenuViewController.h"

@interface LVTitleMenuViewController ()

@end

@implementation LVTitleMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    self.tableView.bounces = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"好友";

    }else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"密友";

    }else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"特别关注";

    }else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"全部";

    }
    
    //cell不能点击.
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}



@end
