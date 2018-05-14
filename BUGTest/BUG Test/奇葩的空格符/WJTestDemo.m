//
//  WJTestDemo.m
//  BUGTest
//
//  Created by Mac on 2018/5/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WJTestDemo.h"

@implementation WJTestDemo

+ (BOOL)string:(NSString *)str
{
    NSString *regExpStr = @"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regExpStr];
    return [predicate evaluateWithObject:str];
    
#warning AAAAA 上面是从聊天记录拷贝过来（上面的）没有事，下面的就会崩溃
    //    NSString *regExpStr = @"[0-9]*";
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExpStr];
    //    return [predicate evaluateWithObject:str];
}

//  奇葩空格符的BUG
+ (void)errorStr
{
    NSString *str_0 = @"F S ";  // 未知状态下
    NSString *str_1 = @"F S ";  // 英文状态下
    
    if ([str_0 isEqualToString:str_1]) {
        NSLog(@"是一样的啊！！！");
    }
    else
    {
        NSLog(@"是不一样的！！！");
        NSLog(@"str_0 --- %@", [str_0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
        NSLog(@"str_1 --- %@", [str_1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
    }
}

@end
