//
//  LVUser.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/8.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVUser.h"

@implementation LVUser

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    LVUser *user = [[LVUser alloc]init];
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    
    return user;
}

@end
