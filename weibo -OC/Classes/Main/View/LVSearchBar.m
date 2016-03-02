//
//  LVSearchBar.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/2.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVSearchBar.h"

@implementation LVSearchBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"搜索";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        //创建搜索栏左边小放大镜
        UIImageView *searchIcon = [[UIImageView alloc]init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.height = 30;
        searchIcon.width = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}


+ (instancetype)searchBar
{
    return [[self alloc]init];
}

@end
