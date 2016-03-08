//
//  LVStatus.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/8.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVStatus.h"
#import "LVUser.h"

@implementation LVStatus

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    LVStatus *status = [[LVStatus alloc]init];
    
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [LVUser initWithDict:dict[@"user"]];
    
    return status;
    
}

@end
