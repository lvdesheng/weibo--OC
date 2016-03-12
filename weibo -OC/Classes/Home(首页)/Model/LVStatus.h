//
//  LVStatus.h
//  weibo -OC
//
//  Created by lvdesheng on 16/3/8.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LVUser;
@interface LVStatus : NSObject

/**idstr	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/**text	string	微博信息内容 */
@property (nonatomic, copy) NSString *text;

/**user	object	微博作者的用户信息字段 详细*/
@property (nonatomic, strong)  LVUser *user;

/**created_at	string	微博创建时间 */
@property (nonatomic, copy) NSString *created_at;

/**source	string	微博来源 */
@property (nonatomic, copy) NSString *source;

/** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
@property (nonatomic, strong) NSArray *pic_urls;

/**被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic, strong) LVStatus *retweeted_status;

/** reposts_count	int	转发数*/
@property (nonatomic, assign)NSInteger reposts_count;

/** comments_count	int	评论数*/
@property (nonatomic, assign)NSInteger comments_count;

/**attitudes_count*/
@property (nonatomic, assign)NSInteger attitudes_count;
@end
