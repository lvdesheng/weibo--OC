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



@end
