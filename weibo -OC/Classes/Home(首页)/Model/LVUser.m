//
//  LVUser.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/8.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVUser.h"

@implementation LVUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

@end
