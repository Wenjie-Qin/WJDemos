//
//  WJStringHelper.m
//  BSGK
//
//  Created by admin on 2017/12/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "WJStringHelper.h"

@implementation WJStringHelper

/*  判断字符串是否为空：nil、@""、空格、回车都算
 *
 *  @param str 需要判断的字符串
 *
 *  return YES 或 NO
 */
+ (BOOL)isEmpty:(NSString *)str
{
    if (!str) {
        return YES;
    }
    else
    {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedStr = [str stringByTrimmingCharactersInSet:set];
        if (trimedStr.length==0) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

/*  判断字符串不为空
 *
 *  @param str 需要判断的字符串
 *
 *  return  YES 或 NO
 */
+ (BOOL)isNotEmpty:(NSString *)str
{
    if (!str) {
        return NO;
    }
    else
    {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedStr = [str stringByTrimmingCharactersInSet:set];
        if (trimedStr.length==0) {
            return NO;
        }
        else
        {
            return YES;
        }
    }
}

/*  判断字符串仅包含数字
 *
 *  @param str 需要判断的字符串
 *
 *  return YES 或 NO
 */
+ (BOOL)onlyNum:(NSString *)str
{
    if (str) {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        if (str.length == 0) {
            return YES;
        }
    }
    
    return NO;
}

/*  判断字符串是否满足某一正则表达式
 *
 *  @param str    需要判断的字符串
 *  @param regExp 正则表达式
 *
 *  return
 */
+ (BOOL)string:(NSString *)str regExp:(WJStringRegExp)regExp
{
    NSString *regExpStr = [self getRegExpStr:regExp];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regExpStr];
    return [predicate evaluateWithObject:str];
    
#warning AAAAAAAAAA 和大勇的聊天记录拷贝过来（上面的）就没有事，我自己写的就会崩溃
//    NSString *regExpStr = [self getRegExpStr:regExp];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExpStr];
//    return [predicate evaluateWithObject:str];
}

/*  获取常见正则表达式
 *
 *  @param regExp 正则表达式类型
 *
 *  return 字符串（正则表达式）
 */
+ (NSString *)getRegExpStr:(WJStringRegExp)regExp
{
    if (regExp==WJStringRegExpIDCard) {
        return @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    }
    else if (regExp==WJStringRegExpOnlyNumber) {
        return @"[0-9]*";
    }
    else if (regExp==WJStringRegExpPhoneNumber) {
        return @"^[0-9]{11}";
    }
    else if (regExp==WJStringRegExpPassword6_18) {
        return @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    }
    else
    {
        return @"";
    }
}

/*  获取一个不为空的字符串
 *
 *  @param str 需要校验的字符串
 *
 *  return 不为空的字符串
 */
+ (NSString *)getNotEmptyStr:(NSString *)str
{
    if (str) {
        return [NSString stringWithFormat:@"%@", str];
    }
    
    return @"";
}

/*  获取一个不为空的字符串 且给定为空时的替换字符
 *
 *  @param str 需要校验的字符串
 *  @param rep 为空后作为替换的字符串
 *
 *  return 不为空的字符串
 */
+ (NSString *)checkEmpty:(NSString *)str replace:(NSString *)rep
{
    if ([WJStringHelper isNotEmpty:str]) {
        return str;
    }
    
    return rep;
}

/*  网址链接转码（链接“url”加载WebView时，其中可能有中文、特殊符号&％和空格，必须进行转译才能正确访问）
 *
 *  @param str  含有“中文”等特殊字符的URL
 *
 *  return 正确的URL
 */
+ (NSString *)transcodeHTTPRealUrl:(NSString *)str
{
    // 第一次转码
    NSString *oneTranscode = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    
    // 第二次转码
    NSString *twoTranscode = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)oneTranscode, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    
    return twoTranscode;
}





@end
