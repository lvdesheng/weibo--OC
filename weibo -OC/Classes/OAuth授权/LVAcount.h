//
//  LVAcount.h
//  weibo -OC
//
//  Created by lvdesheng on 16/3/5.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LVAcount : NSObject

/*
 access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in     string	access_token的生命周期，单位是秒数。
 uid            string	当前授权用户的UID。
 */



/**access_token	用于调用access_token，接口获取授权后的access token。 */
@property (nonatomic, copy) NSString *access_token;
/**
 *   expires_in  string	access_token的生命周期，单位是秒数。
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *   uid   string	当前授权用户的UID。
 */
@property (nonatomic, copy) NSString *uid;

/**access_token 创建时间*/
@property (nonatomic, strong) NSDate *creat_time;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
