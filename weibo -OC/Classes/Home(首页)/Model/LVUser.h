//
//  LVUser.h
//  weibo -OC
//
//  Created by lvdesheng on 16/3/8.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LVUser : NSObject

/**idstr	string	字符串型的用户UID */
@property (nonatomic, copy) NSString *idstr;

/**name	string	友好显示名称 */
@property (nonatomic, copy) NSString *name;

/**profile_image_url	string	用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;

+ (instancetype)initWithDict:(NSDictionary *)dict;

@end
