//
//  LVAccountTool.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/5.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVAccountTool.h"

#define LVAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"account.archive"]

@implementation LVAccountTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(LVAcount *)account
{
    //获取账号的存储的时间
    account.creat_time = [NSDate date];
    
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:LVAccountPath];
}
/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (LVAcount *)account
{
    //加载模型
    LVAcount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:LVAccountPath];
    
    /**验证账号是否过期 */
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    // 获得过期时间
    NSDate *expiresTime = [account.creat_time dateByAddingTimeInterval:expires_in];
    // 获得当前时间
    NSDate *now = [NSDate date];
    
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
   
    return account;
}










@end
