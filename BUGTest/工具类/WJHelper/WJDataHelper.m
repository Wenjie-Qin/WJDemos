//
//  WJDataHelper.m
//  JDZS
//
//  Created by Mac on 2018/3/28.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WJDataHelper.h"

@implementation WJDataHelper

/*  获取用户所在经纬度、以及地区
 *
 *  @param area 所在地区
 *  @param lat  纬度值
 *  @param lng  经度值
 *
 *  return 无返回值
 */
+ (void)getUserLocation:(void (^)(NSString *area))area lat:(void (^)(NSString *lat))lat lng:(void (^)(NSString *lng))lng
{
    
}

/*  校验更正本地存储的内容
 *
 *  @param dic  将要存储的数据内容
 *
 *  return 安全数据
 */
+ (NSDictionary *)checkAndChangeData:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [dic mutableCopy];
    NSArray *keys = [mdic allKeys];
    for (NSString *key in keys) {
        id obj = mdic[key];
        if (obj == [NSNull null]) {
            [mdic setObject:@"" forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:mdic];
}


@end
