//
//  LVStatus.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/8.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVStatus.h"
#import "LVUser.h"
#import "MJExtension.h"
#import "LVPhoto.h"


@implementation LVStatus

+ (NSDictionary *)mj_objectClassInArray
{
     return  @{@"pic_urls" : [LVPhoto class]};
}
@end
