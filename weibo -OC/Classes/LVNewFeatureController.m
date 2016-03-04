//
//  LVNewFeatureController.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/4.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVNewFeatureController.h"
#define LVNewFeatureCount 4
@interface LVNewFeatureController ()<UIScrollViewDelegate>


@property (nonatomic, weak)  UIScrollView *ScrollView;

/**PageControl*/
@property (nonatomic, weak)  UIPageControl *PageControl;
@end

@implementation LVNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.创建一个scrollView：显示所有的新特性图片
    
    UIScrollView *ScrollView = [[UIScrollView alloc]init];
    ScrollView.frame = self.view.bounds;
    [self.view addSubview:ScrollView];
    ScrollView.backgroundColor = LVRandomColor;
    self.ScrollView = ScrollView;
    // 2.添加图片到scrollView中
    
    CGFloat scrollW = ScrollView.width;
    CGFloat scrollH = ScrollView.height;
    
    for (int i = 0; i < LVNewFeatureCount ; i++) {
        UIImageView *ImageView = [[UIImageView alloc]init];
        //显示图片
        CGFloat imageViewW = ScrollView.width;
        CGFloat imageViewH = ScrollView.height;
        CGFloat imageViewX = i * imageViewW;
        CGFloat imageViewY = 0;
        ImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        ImageView.image = [UIImage imageNamed:name];
        
        [ScrollView addSubview:ImageView];
    }
    
    //设置scrollView的其他属性
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    ScrollView.contentSize = CGSizeMake(LVNewFeatureCount * scrollW, 0);
    ScrollView.bounces = NO;//去掉弹簧效果
    ScrollView.pagingEnabled = YES;
    ScrollView.showsHorizontalScrollIndicator = NO;
    ScrollView.delegate = self;
    
    
    //添加pageControll分页 展示目前到第几页
    
    UIPageControl *PageControl = [[UIPageControl alloc ]init];
    PageControl.numberOfPages = LVNewFeatureCount;
    PageControl.backgroundColor = [UIColor redColor];
    PageControl.currentPageIndicatorTintColor = LVColor(253, 98, 42);
    PageControl.pageIndicatorTintColor = LVColor(189, 189, 189);
    PageControl.centerX = scrollW * 0.5;
    PageControl.centerY = scrollH - 50;
    [self.view addSubview:PageControl];
    self.PageControl = PageControl;
   
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page =  scrollView.contentOffset.x / scrollView.width;
    //四舍五入计算页码
    self.PageControl.currentPage =(int) (page + 0.5);
    // 1.3四舍五入 1.3 + 0.5 = 1.8 强转为整数(int)1.8= 1
    // 1.5四舍五入 1.5 + 0.5 = 2.0 强转为整数(int)2.0= 2
    // 1.6四舍五入 1.6 + 0.5 = 2.1 强转为整数(int)2.1= 2
    // 0.7四舍五入 0.7 + 0.5 = 1.2 强转为整数(int)1.2= 1
    
}

@end
