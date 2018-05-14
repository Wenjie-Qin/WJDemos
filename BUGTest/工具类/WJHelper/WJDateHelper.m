//
//  WJDateHelper.m
//  BSGK
//
//  Created by admin on 2017/12/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "WJDateHelper.h"

@implementation WJDateHelper

/*  将一个日期格式的字符串截取成 只有年月日的字符串
 *
 *  @param dateStr 需要被处理的字符串
 *
 *  return 返回“yyyy-MM-dd”类型的字符串
 */
+ (NSString *)getNYRForDateStr:(NSString *)dateStr
{
    NSString *dateFormat = @"yyyy-MM-dd";
    NSInteger formatLen  = dateFormat.length;
    NSString *nyrStr     = [dateStr substringToIndex:formatLen];
    return nyrStr;
}

/*  获取日期 例（如下）：
 *  当天          -- 09:24
 *  昨天          -- 昨天 09:24
 *  昨天之前在当年  -- 12-26 09:24
 *  不在当年       -- 2017-12-26 09:24
 *
 *  @param dateStr 需要被处理的字符串
 *
 *  return 返回被描述过的 日期
 */
+ (NSString *)desDate:(NSString *)dateStr
{
    
    NSTimeInterval secondsPerDay = 24*60*60;
    NSDate *yearsterDay = [NSDate dateWithTimeIntervalSinceNow:-secondsPerDay];
    NSDate *today       = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *yearsterDayComp = [calender components:unitFlags fromDate:yearsterDay];
    NSDateComponents *todayComp       = [calender components:unitFlags fromDate:today];
    NSDateComponents *dateStrComp     = [calender components:unitFlags fromDate:date];
    
    if (todayComp.year==dateStrComp.year&&
        todayComp.month==dateStrComp.month&&
        todayComp.day==dateStrComp.day) {
        [dateFormat setDateFormat:@"HH:mm"];
        NSString *desToday = [dateFormat stringFromDate:date];
        return desToday; // 当天 例：09:24
    }
    
    if (yearsterDayComp.year==dateStrComp.year) {
        if (yearsterDayComp.month==dateStrComp.month&&
            yearsterDayComp.day==dateStrComp.day) {
            [dateFormat setDateFormat:@"HH:mm"];
            NSString *desYearsterDay = [dateFormat stringFromDate:date];
            desYearsterDay = [NSString stringWithFormat:@"昨天 %@", desYearsterDay];
            return desYearsterDay; // 昨天 例：昨天 09:24
        }
        else
        {
            [dateFormat setDateFormat:@"MM-dd HH:mm"];
            NSString *desBeforeDay = [dateFormat stringFromDate:date];
            return desBeforeDay; // 昨天之前在当年 例：12-26 09:24
        }
    }
    else
    {
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *desBeforeYear = [dateFormat stringFromDate:date];
        return desBeforeYear; // 不在当年 例：2017-12-26 09:24
    }
}

/*  获取当天日期（例如：1月5日 星期五）
 *
 *  return 获取当天日期（包括星期几）
 */
+ (NSString *)getCurDateAndWeek
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"M月d日"];
    NSString *dateTime = [formatter stringFromDate:date];
    
    NSArray *weekdays       = [NSArray arrayWithObjects: [NSNull null],@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",nil];
    NSCalendar *calendar    = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone    = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit     = NSCalendarUnitWeekday;
    NSDateComponents*theComponents  = [calendar components:calendarUnit fromDate:date];
    NSString *weekTime = [weekdays objectAtIndex:theComponents.weekday];
    return [NSString stringWithFormat:@"%@  %@",dateTime,weekTime];
}



@end
