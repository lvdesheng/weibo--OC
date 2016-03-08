//
//  LVFooter.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/8.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVFooter.h"

@implementation LVFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LVFooter" owner:nil options:nil] lastObject];
    
}


@end
