//
//  MBHUDMacro.h
//  JDZS
//
//  Created by Mac on 2018/3/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#ifndef MBHUDMacro_h
#define MBHUDMacro_h

//  成功、失败的图片宏
#define ERROR_IMG       [[UIImage imageNamed:@"Checkmark_Fail"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
#define SUCCEED_IMG     [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]


/***************************** 在VC中展示 *****************************/

// 展示在VC中
#define SHOW_VC_HUD             self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

// 隐藏HUD
#define HIDE_VC_HUD             [self.hud hideAnimated:YES];

// 延时一段时间后隐藏HUD
#define DELAY_HIDE_VC_HUD       [self.hud hideAnimated:YES afterDelay:1.0f];

// 旋转带字
#define SHOW_VC_LABEL_HUD(msg)  [self.hud hideAnimated:YES];\
self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];\
self.hud.label.text = NSLocalizedString(msg, @"HUD loading title");\

// 旋转显示两行文字
#define SHOW_VC_TWO_LABEL_HUD(title, msg)   [self.hud hideAnimated:YES];\
self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];\
self.hud.mode = MBProgressHUDModeText;\
self.hud.label.text = NSLocalizedString(title, @"HUD loading title");\
self.hud.detailsLabel.text = NSLocalizedString(msg, @"HUD title");\
[self.hud hideAnimated:YES afterDelay:1.0f];

/*  失败（图）带字
 *
 *  @param msg          展示的文字
 *  @param delayTime    延迟时间 -- 为0 时，一直旋转，等待外界控制隐藏
 */
#define SHOW_VC_ERROR_HUD(msg, delayTime)   [self.hud hideAnimated:YES];\
self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];\
self.hud.mode = MBProgressHUDModeCustomView;\
self.hud.customView = [[UIImageView alloc] initWithImage:ERROR_IMG];\
self.hud.label.text = NSLocalizedString(msg, @"HUD done title");\
if (delayTime != 0) {\
    [self.hud hideAnimated:YES afterDelay:delayTime];\
}

/*  成功（图）带字
 *
 *  @param msg          展示的文字
 *  @param delayTime    延迟时间 -- 为0 时，一直旋转，等待外界控制隐藏
 */
#define SHOW_VC_SUCCEED_HUD(msg, delayTime) [self.hud hideAnimated:YES];\
self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];\
self.hud.mode = MBProgressHUDModeCustomView;\
self.hud.customView = [[UIImageView alloc] initWithImage:SUCCEED_IMG];\
self.hud.label.text = NSLocalizedString(msg, @"HUD done title");\
if (delayTime != 0) {\
[self.hud hideAnimated:YES afterDelay:delayTime];\
}


/***************************** 在Window中展示 *****************************/

// 旋转
#define SHOW_WINDOW_HUD         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];

// 停止
#define HIDE_HUD                [hud hideAnimated:YES];

// 延迟几秒停止
#define HIDE_HUD_DELAY(time)    [hud hideAnimated:YES afterDelay:time];

// 旋转 带字
#define SHOE_LABEL_HUD(msg)     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];\
hud.label.text = NSLocalizedString(msg, @"HUD loading title");\

// 旋转 只显示两行文字
#define SHOW_TwoLabel_HUD(title, msg)   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];\
hud.mode = MBProgressHUDModeText;\
hud.label.text = NSLocalizedString(title, @"HUD loading title");\
hud.detailsLabel.text = NSLocalizedString(msg, @"HUD title");\
[hud hideAnimated:YES afterDelay:1.0f];

// 失败（图）带字
#define SHOW_ERROR_OBLONG_HUD(msg)      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];\
hud.mode = MBProgressHUDModeCustomView;\
hud.customView = [[UIImageView alloc] initWithImage:ERROR_IMG];\
hud.label.text = NSLocalizedString(msg, @"HUD done title");\
[hud hideAnimated:YES afterDelay:1.0f];

// 失败 显示两行字体
#define SHOW_ERROR_DETAIL_HUD(title, msg, delayTime)  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];\
hud.mode = MBProgressHUDModeCustomView;\
hud.customView = [[UIImageView alloc] initWithImage:ERROR_IMG];\
hud.label.text = NSLocalizedString(title, @"HUD loading title");\
hud.detailsLabel.text = NSLocalizedString(msg, @"HUD title");\
[hud hideAnimated:YES afterDelay:delayTime];

// 成功（图）带字
#define SHOW_SUCCEED_HUD(msg)       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];\
hud.mode = MBProgressHUDModeCustomView;\
hud.customView = [[UIImageView alloc] initWithImage:SUCCEED_IMG];\
hud.label.text = NSLocalizedString(msg, @"HUD done title");\
[hud hideAnimated:YES afterDelay:1.0f];

// 成功 显示两行字体
#define SHOW_SUCCEED_DETAIL_HUD(title, msg, delayTime)  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];\
hud.mode = MBProgressHUDModeCustomView;\
hud.customView = [[UIImageView alloc] initWithImage:SUCCEED_IMG];\
hud.label.text = NSLocalizedString(title, @"HUD loading title");\
hud.detailsLabel.text = NSLocalizedString(msg, @"HUD title");\
[hud hideAnimated:YES afterDelay:delayTime];


#endif /* MBHUDMacro_h */
