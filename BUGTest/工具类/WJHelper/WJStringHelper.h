//
//  WJStringHelper.h
//  BSGK
//
//  Created by admin on 2017/12/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WJStringRegExp) {
    WJStringRegExpOnlyNumber    = 0,    // 纯数字
    WJStringRegExpPassword6_18  = 1,    // 密码：有英文有数字6-18 位
    WJStringRegExpPhoneNumber   = 2,    // 手机号：A.11位 B.全部为数字
    WJStringRegExpIDCard        = 3     // 身份证号
};

@interface WJStringHelper : NSObject

/*  判断字符串是否为空：nil、@""、空格、回车都算
 *
 *  @param str 需要判断的字符串
 *
 *  return YES 或 NO
 */
+ (BOOL)isEmpty:(NSString *)str;

/*  判断字符串不为空
 *
 *  @param str 需要判断的字符串
 *
 *  return YES 或 NO
 */
+ (BOOL)isNotEmpty:(NSString *)str;

/*  判断字符串仅包含数字
 *
 *  @param str 需要判断的字符串
 *
 *  return YES 或 NO
 */
+ (BOOL)onlyNum:(NSString *)str;

/*  判断字符串是否满足某一正则表达式
 *
 *  @param str    需要判断的字符串
 *  @param regExp 正则表达式类型
 *
 *  return YES 或 NO
 */
+ (BOOL)string:(NSString *)str regExp:(WJStringRegExp)regExp;

/*  获取常见正则表达式
 *
 *  @param regExp 正则表达式类型
 *
 *  return 字符串（正则表达式）
 */
+ (NSString *)getRegExpStr:(WJStringRegExp)regExp;

/*  获取一个不为空的字符串
 *
 *  @param str 需要校验的字符串
 *
 *  return 不为空的字符串
 */
+ (NSString *)getNotEmptyStr:(NSString *)str;

/*  获取一个不为空的字符串 且给定为空时的替换字符
 *
 *  @param str 需要校验的字符串
 *  @param rep 为空后作为替换的字符串
 *
 *  return 不为空的字符串
 */
+ (NSString *)checkEmpty:(NSString *)str replace:(NSString *)rep;

/*  网址链接转码（链接“url”加载WebView时，其中可能有中文、特殊符号&％和空格，必须进行转译才能正确访问）
 *  !!! 据说要两次转码
 *
 *  @param str  含有“中文”等特殊字符的URL
 *
 *  return 正确的URL
 */
+ (NSString *)transcodeHTTPRealUrl:(NSString *)str;




@end
