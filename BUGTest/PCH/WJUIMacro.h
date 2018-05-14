//
//  WJUIMacro.h
//  JDZS
//
//  Created by Mac on 2018/3/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#ifndef WJUIMacro_h
#define WJUIMacro_h

#define wj_dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#warning AAAAA  以后要更改成类型常量的定义
#define KEYBOARD_ANIMATION_DU   0.25

#define USER_PH_HEAD        [UIImage imageNamed:@"user_head"]       // 用户头像
#define HEA_PLACEHOLDER     [UIImage imageNamed:@"WJ_HEA_PL"]       // 家电占位图
#define TODAY_PLACEHOLDER   [UIImage imageNamed:@"WJ_HEA_PL"]       // Today占位图
#define EMPTY_PH_ICON       [UIImage imageNamed:@"mine_no_HEA_PL.jpg"]  // 空数据
#define SEAR_EMPTY_PH       [UIImage imageNamed:@"search_empty_icon"]   // 搜索为空


#define WJ_FONT_PINGFANG(a)     [UIFont fontWithName:@"PingFangSC-Semibold" size:[global pxTopt:(a*2)]]
#define WJ_FONT_DISPLAY(a)      [UIFont fontWithName:@"SFNSDisplay" size:[global pxTopt:(a*2)]]

#define FONT_10_AU              font(20)
#define FONT_12_AU              font(24)
#define FONT_13_AU              font(26)
#define FONT_14_AU              font(28)
#define FONT_15_AU              font(30)
#define FONT_16_AU              font(32)
#define FONT_17_AU              font(34)




#define COLOR_333               WJ_RGB_H(0x141414)
#define COLOR_666               WJ_RGB_H(0x8C8B8F)
#define COLOR_999               WJ_RGB_H(0x9B9B9B)

#define COLOR_PRICE_RED         WJ_RGB_H(0xe24242)
#define COLOR_LINE              WJ_RGB_H(0xdfdfdf)
#define COLOR_YELLOW            WJ_RGB_H(0xf6b132)
#define COLOR_WHITE             [UIColor whiteColor]

#define BACKGROUND_COLOR        WJ_RGB_H(0xfafafa)
#define THEME_COLOR             WJ_RGB_H(0xFFC27D)
#define NAVBAR_COLOR            WJ_RGB_H(0xfafafa)
#define NAVBAR_ITEM_COLOR       [UIColor blackColor]

#define WJ_RGB_D(r, g, b ,a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define WJ_RGB_H(rgbValue)      [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]



#define f_Device_w              [UIScreen mainScreen].bounds.size.width
#define f_Device_h              [UIScreen mainScreen].bounds.size.height

#define UP_ZERO                 0

#define Statusbar_H             ([WRNavigationBar isIphoneX]?44.0f: 20.0f)
#define Tab_Bar_H               [WRNavigationBar tabBarHeight]
#define Nav_Bar_H               [WRNavigationBar navBarBottom]

#define NoNavbar_H              (f_Device_h-Nav_Bar_H)
#define NoTabBar_H              (f_Device_h-Tab_Bar_H)
#define NoBar_H                 (f_Device_h-Nav_Bar_H-Tab_Bar_H)

#define W_i6real(f)             (f_Device_w * ((f)/375.f))
#define W_i6ORi5(f)             (f_Device_w>375?(f_Device_w * ((f)/375.f)):(f))
#define NAV_ITME_LEFT           16
#define NAV_ITME_SPACE          6
#define NAV_ITME_W              40



//  为视图添加圆角、设置阴影
#define WJ_ADD_corner_shadow(targetView, cornerRadius, shadowRadius, shadowOpacity, shadowOffsetX, shadowOffsetY)  if (cornerRadius>0) {\
[targetView.layer setMasksToBounds:YES];\
[targetView.layer setCornerRadius:cornerRadius];\
}\
if (shadowRadius>0) {\
[targetView.layer setShadowRadius:shadowRadius];\
}\
[targetView.layer setShadowOpacity:shadowOpacity];\
if (shadowOffsetX>0||shadowOffsetY>0) {\
CGSize shadowOffset = CGSizeMake(shadowOffsetX, shadowOffsetY);\
[targetView.layer setShadowOffset:shadowOffset];\
}\
[targetView.layer setMasksToBounds:false];

#endif /* WJUIMacro_h */
