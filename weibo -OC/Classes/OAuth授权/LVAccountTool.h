//
//  LVAccountTool.h
//  weibo -OC
//
//  Created by lvdesheng on 16/3/5.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LVAcount;

@interface LVAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(LVAcount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (LVAcount *)account;

@end
