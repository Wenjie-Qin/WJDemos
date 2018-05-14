//
//  WJDateHelper.h
//  BSGK
//
//  Created by admin on 2017/12/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJDateHelper : NSObject

/*  将一个日期格式的字符串截取成 只有年月日的字符串
 *
 *  @param dateStr 需要被处理的字符串
 *
 *  return 返回“yyyy-MM-dd”类型的字符串
 */
+ (NSString *)getNYRForDateStr:(NSString *)dateStr;

/*  获取消息日期 例（如下）：
 *  当天          -- 09:24
 *  昨天          -- 昨天 09:24
 *  昨天之前在当年  -- 12-26 09:24
 *  不在当年       -- 2017-12-26 09:24
 *
 *  @param dateStr 需要被处理的字符串
 *
 *  return 返回被描述过的 日期
 */
+ (NSString *)desDate:(NSString *)dateStr;

/*  获取当天日期（例如：1月5日 星期五）
 *
 *  return 获取当天日期（包括星期几）
 */
+ (NSString *)getCurDateAndWeek;

@end
