//
//  WJUIHelper.m
//  BZZJB
//
//  Created by admin on 2018/1/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "WJUIHelper.h"

@implementation WJUIHelper

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
+ (CGRect)realRect:(CGFloat)viewWidth lastRect:(CGRect)lastRect space:(CGFloat)space beginX:(CGFloat)beginX itemWidth:(CGFloat)newItemWidth 
{
    CGRect realRect         = CGRectZero;
    CGFloat lastItemHeight  = lastRect.size.height;
    CGFloat lastItemY       = lastRect.origin.y;
    CGFloat newItemWillX    = CGRectGetMaxX(lastRect)+space;
    
    if (newItemWillX+newItemWidth<=viewWidth) {
        // 本行可完整展示
        realRect = CGRectMake(newItemWillX, lastItemY, newItemWidth, lastItemHeight);
    }
    else
    {
        // 换行显示、回到初始横坐标
        CGFloat newItemY = CGRectGetMaxY(lastRect)+space;
        realRect = CGRectMake(beginX, newItemY, newItemWidth, lastItemHeight);
    }
    
    return realRect;
}

/*  获取一张“正片叠底”的照片
 *
 *  @param bgImg    背景照片 （不设置默认背景色的那张图片）
 *  @param image    上层照片
 *
 *  return 返回“正片叠底”的照片
 */
+ (UIImage *)wjMultiplyIconBgImg:(UIImage *)bgImg image:(UIImage *)image
{
    if (!bgImg) {
        bgImg = [UIImage imageNamed:@"wj_zpdd_bg"];
    }
    
    CGSize img_size = image.size;
    
    UIGraphicsBeginImageContext(img_size);
    [bgImg drawInRect:CGRectMake(0, 0, img_size.width, img_size.height) blendMode:kCGBlendModeNormal alpha:1];
    [image drawInRect:CGRectMake(0, 0, img_size.width, img_size.height) blendMode:kCGBlendModeMultiply alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();    
    return newImage;
}

/*  获取一张以某颜色为背景的图片
 *
 *  @param color    某颜色
 *
 *  return 以某颜色为背景的图片
 */
+ (UIImage *)wjColorIcon:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/*  将一个UIView 转化成 UIImage
 *
 *  @param view 需要转化的View
 *
 *  return 一张图片
 */
+ (UIImage *)getImageFromView:(UIView *)view
{
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    //2.获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //3.截屏
    [view.layer renderInContext:ctx];
    
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return newImage;
}

/*  将一张图片保存在本地
 *
 *  @param image 需要保存的图片
 *
 *  return 无返回值
 */
+ (void)saveImage:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        
        SHOW_ERROR_OBLONG_HUD(@"保存图片失败，请重试")
    }
    else
    {
        SHOW_SUCCEED_HUD(@"图片已保存至您的手机")
    }
}

/*  获取设置完行间距，根据宽、字符串后段落的高度
 *
 *  @param str          文本
 *  @param font         字体
 *  @param lineSpacing  行间距
 *  @param width        label的宽度
 *
 *  return 返回段落的高
 */
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing withWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode     = NSLineBreakByCharWrapping;
    paraStyle.alignment         = NSTextAlignmentLeft;
    paraStyle.lineSpacing       = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.headIndent        = 0;
    paraStyle.tailIndent        = 0;
    paraStyle.firstLineHeadIndent       = 0.0;
    paraStyle.paragraphSpacingBefore    = 0.0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, f_Device_h) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
}

/*  设置段落的行间距，根据宽、字符串
 *
 *  @param label        label
 *  @param str          文本
 *  @param font         字体
 *  @param lineSpacing  行间距
 *
 *  return 无返回值
 */
+ (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing
{
    if ([WJStringHelper isEmpty:str]) {
        return;
    }
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode     = NSLineBreakByCharWrapping;
    paraStyle.alignment         = NSTextAlignmentLeft;
    paraStyle.lineSpacing       = lineSpacing; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.headIndent        = 0;
    paraStyle.tailIndent        = 0;
    paraStyle.firstLineHeadIndent       = 0.0;
    paraStyle.paragraphSpacingBefore    = 0.0;
    
    // 设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}


@end
