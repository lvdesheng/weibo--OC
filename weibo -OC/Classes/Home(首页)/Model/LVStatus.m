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

/**
 1.今年
 1> 今天
 * 1分内： 刚刚
 * 1分~59分内：xx分钟前
 * 大于60分钟：xx小时前
 
 2> 昨天
 * 昨天 xx:xx
 
 3> 其他
 * xx-xx xx:xx
 
 2.非今年
 1> xxxx-xx-xx xx:xx
 */

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    //微博创建日期
    NSDate *creatDate = [fmt dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    //日历对象(方便比较两个日期之间的差距）
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [Calendar components:unit fromDate:creatDate toDate:now options:0];
    
    if ([creatDate isYesterday]){//今年
        
        if ([creatDate isYesterday]){//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:creatDate];
        }else if ([creatDate isToday]){//今天
            if (cmps.hour >= 1){
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }else if(cmps.minute >= 1 ){
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else{//今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:creatDate];
        }
    }else{//非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:creatDate];
    }
   
    return _created_at;
}


- (void)setSource:(NSString *)source
{
    // 正则表达式 NSRegularExpression
    // 截串 NSString
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    //    range.length = [source rangeOfString:@"<" options:NSBackwardsSearch];
    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
    
}


@end
