//
//  WJUIHelper.h
//  BZZJB
//
//  Created by admin on 2018/1/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJUIHelper : NSObject

/*  获取真实坐标（蛇形排列时，一行显示不完整后要换行）
 *
 *  @param viewWidth    承载视图的宽
 *  @param lastRect     上一个标签的坐标
 *  @param itemWidth    将要展示的标签的宽
 *  @param space        间隔
 *  @param beginX       开始坐标
 *
 *  return 标签真实坐标
 */
+ (CGRect)realRect:(CGFloat)viewWidth lastRect:(CGRect)lastRect space:(CGFloat)space beginX:(CGFloat)beginX itemWidth:(CGFloat)newItemWidth;

/*  获取一张“正片叠底”的照片
 *
 *  @param size     区间范围
 *  @param bgImg    背景照片
 *  @param image    上层照片
 *
 *  return 返回“正片叠底”的照片
 */
+ (UIImage *)wjMultiplyIconBgImg:(UIImage *)bgImg image:(UIImage *)image;

/*  获取一张以某颜色为背景的图片
 *
 *  @param color    某颜色
 *
 *  return 以某颜色为背景的图片
 */
+ (UIImage *)wjColorIcon:(UIColor *)color;

/*  将一个UIView 转化成 UIImage
 *
 *  @param view 需要转化的View
 *
 *  return 一张图片
 */
+ (UIImage *)getImageFromView:(UIView *)view;

/*  将一张图片保存在本地
 *
 *  @param image 需要保存的图片
 *
 *  return 无返回值
 */
+ (void)saveImage:(UIImage *)image;

/*  获取设置完行间距，根据宽、字符串后段落的高度
 *
 *  @param str          文本
 *  @param font         字体
 *  @param lineSpacing  行间距
 *  @param width        label的宽度
 *
 *  return 返回段落的高
 */
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing withWidth:(CGFloat)width;

/*  设置段落的行间距，根据宽、字符串
 *
 *  @param label        label
 *  @param str          文本
 *  @param font         字体
 *  @param lineSpacing  行间距
 *
 *  return 无返回值
 */
+ (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing;



@end
