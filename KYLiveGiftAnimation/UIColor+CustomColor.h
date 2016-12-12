//
//  UIColor+CustomColor.h
//  jiangzhi
//
//  Created by Cobb on 15/5/15.
//  Copyright (c) 2015年 Hu Zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (CustomColor)

/**
 * 十六进制的颜色值转换为颜色UIColor（带透明度）
 */
+(UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

/**
 * 十六进制的颜色值转换为颜色UIColor
 */
+(UIColor*) colorWithHex:(NSInteger)hexValue;

/**
 * 边框颜色
 **/
+(UIColor *)borderColor;

/**
 * app button 高亮颜色
 */
+ (UIColor*)bottonHightColor;

/**
 * app 主色调
 */
+ (UIColor*)mainColor;

/**
 * app 导航颜色
 */
+ (UIColor*)navColor;
/**
 * app 白色的底的时候 分割线的颜色
 */
+ (UIColor*)whiteBackgroundWithLineColor;
/**
 * app 导航分隔线颜色
 */
+ (UIColor*)navLineColor;
/**
 * app 导航title 字体颜色
 */
+ (UIColor*)navTitleColor;

/**
 * 颜色UIColor获取十六进制的颜色值
 */
+(NSString *) hexFromUIColor: (UIColor*) color;
/**
* 输入框提示文字颜色
**/
+(UIColor *)placeholderColor;

/**
 * 创建直播界面 Label 标题颜色
 **/
+(UIColor *)liveLabelTilteColor;
/**
 * 全局字体颜色
 **/
+(UIColor *)baseFontColor;
/**
 * app 所有视图的背景颜色
 */
+(UIColor *)backgroundColor;



@end
