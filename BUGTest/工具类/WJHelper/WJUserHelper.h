//
//  WJUserHelper.h
//  BZZJB
//
//  Created by admin on 2018/1/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJUserHelper : NSObject

/*  判断用户是否登录
 *
 *  return YES 或 NO
 */
+ (BOOL)isLogin;

/*  判断用户是否使用iPad登录
 *
 *  return YES 或 NO
 */
+ (BOOL)useIpad;

/*  获取到用户名称
 *
 *  return A.登录状态 昵称 > 姓名 > 手机号
           B.未登录状态 点击登录
 */
+ (NSString *)getUserNmae;

/*  获取中间加密的用户手机号
 *
 *  return A.正常手机号：中间四位隐藏
           B.异常手机号：只显示前三位
           C.无值：暂无手机号
 */
+ (NSString *)getUserPhoneNumber;

/*  获取用户性别（文字）
 *
 *  return 返回用户性别
 */
+ (NSString *)getUserGengerStr;

/*  用户退出登录  移除Token、专家Dic、各个信息
 *
 *  @param logout 退出登录成功回调
 *
 *  return 无返回值
 */
+ (void)logoutFinish:(void (^)(void))logout;

/*  跳转登录界面
 *
 *  @param vc 从vc界面跳转到登录界面
 *
 *  return 无返回值
 */
+ (void)goLogin:(UIViewController *)vc;

/*  本地保存用户数据
 *
 *  @param userInfo 用户数据
 *
 *  return 无返回值
 */
+ (void)saveUserInfo:(NSDictionary *)userInfo;


@end
