//
//  WJUserHelper.m
//  BZZJB
//
//  Created by admin on 2018/1/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "WJUserHelper.h"

@implementation WJUserHelper

/*  判断用户是否登录
 *
 *  return YES 或 NO
 */
+ (BOOL)isLogin
{
    if ([USER_D objectForKey:AUTH_KEY]&&[USER_D objectForKey:SESSION_ID]) {
        return YES;
    }
    
    return NO;
}

/*  判断用户是否使用iPad登录
 *
 *  return YES 或 NO
 */
+ (BOOL)useIpad
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPad"]) {
        return YES;
    }
    
    return NO;
}

/*  获取到用户名称
 *
 *  return A.登录状态 昵称 > 姓名 > 手机号
           B.未登录状态 点击登录
 */
+ (NSString *)getUserNmae
{
    NSString *userName;
    
    if ([self isLogin]) {
        NSDictionary *userDic = [USER_D objectForKey:USER_PTYH];
        NSString *nc = [userDic objectForKey:@"nickname"];
        NSString *xm = [userDic objectForKey:@"username"];
        NSString *sjh = [userDic objectForKey:@"phone"];
        if ([WJStringHelper isNotEmpty:nc]) {
            userName = nc;
        }
        else if ([WJStringHelper isNotEmpty:xm]) {
            userName = xm;
        }
        else
        {
            userName = sjh;
        }
    }
    else
    {
        userName = @"点击登录";
    }
    
    return userName;
}

/*  获取中间加密的用户手机号
 *
 *  return A.正常手机号：中间四位隐藏
           B.异常手机号：只显示前三位
           C.无值：暂无手机号
 */
+ (NSString *)getUserPhoneNumber
{
    NSString *phone = [[USER_D objectForKey:USER_PTYH] objectForKey:@"phone"];
    if ([WJStringHelper isEmpty:phone]) {
        if (![WJUserHelper isLogin]) {
            return @"";
        }
        else
        {
             return @"未绑定手机号";
        }
    }
    else
    {
        NSString *q_3 = [phone substringToIndex:3];
        NSString *h_4 = [phone substringFromIndex:phone.length-4];
        if ([WJStringHelper string:phone regExp:(WJStringRegExpPhoneNumber)]) {
            return [NSString stringWithFormat:@"%@%@%@",q_3,@"****",h_4];
        }
        else
        {
            return [NSString stringWithFormat:@"%@%@",q_3,@"********"];
        }
    }
}

/*  获取用户性别（文字）
 *
 *  return 返回用户性别
 */
+ (NSString *)getUserGengerStr
{
    NSInteger gender = [[[USER_D objectForKey:USER_PTYH] objectForKey:@"gender"] integerValue];
    return gender == 0 ? @"男" : @"女";
}

/*  用户退出登录 移除Token、专家Dic、各个信息
 *
 *  @param logout 退出登录成功回调
 *
 *  return 无返回值
 */
+ (void)logoutFinish:(void(^)(void))logout
{
    [USER_D removeObjectForKey:USER_PTYH];
    [USER_D removeObjectForKey:AUTH_KEY];
    [USER_D removeObjectForKey:SESSION_ID];
    [USER_D removeObjectForKey:REMEMBER_KEY];
    [USER_D synchronize];
    
    if (logout) {
        logout();
    }
}

/*  跳转登录界面
 *
 *  @param vc 从vc界面跳转到登录界面
 *
 *  return 无返回值
 */
+ (void)goLogin:(UIViewController *)vc;
{
    SHOW_ERROR_OBLONG_HUD(@"请先登录")
//    BNLoginViewController *loginVC = [[BNLoginViewController alloc] init];
//    WJBaseNavigationController *nav= [[WJBaseNavigationController alloc] initWithRootViewController:loginVC];
//    [vc presentViewController:nav animated:YES completion:nil];
}

/*  本地保存用户数据
 *
 *  @param userInfo 用户数据
 *
 *  return 无返回值
 */
+ (void)saveUserInfo:(NSDictionary *)userInfo
{
    if (userInfo) {
        NSDictionary *safe_info = [WJDataHelper checkAndChangeData:userInfo];
        [USER_D setObject:safe_info forKey:USER_PTYH];
    }
    
    [USER_D synchronize];
}


@end
