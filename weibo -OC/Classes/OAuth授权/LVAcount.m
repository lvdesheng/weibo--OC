//
//  LVAcount.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/5.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVAcount.h"

@implementation LVAcount


//字典转模型
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    LVAcount *acount = [[LVAcount alloc]init];
    acount.access_token = dict[@"access_token"];
    acount.expires_in   = dict[@"expires_in"];
    acount.uid          = dict[@"uid"];
    //获得账号储存时间
    acount.creat_time = [NSDate date];
    return acount;
}


/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in   forKey:@"expires_in"];
    [encoder encodeObject:self.uid          forKey:@"uid"];
    [encoder encodeObject:self.creat_time   forKey:@"creat_time"];
    [encoder encodeObject:self.name         forKey:@"name"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in   = [decoder decodeObjectForKey:@"expires_in"];
        self.uid          = [decoder decodeObjectForKey:@"uid"];
        self.creat_time   = [decoder decodeObjectForKey:@"creat_time"];
        self.name         = [decoder decodeObjectForKey:@"name"];
        
    }
    return self;
}

@end
