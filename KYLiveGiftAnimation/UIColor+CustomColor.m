//
//  UIColor+CustomColor.m
//  jiangzhi
//
//  Created by Cobb on 15/5/15.
//  Copyright (c) 2015年 Hu Zhiyuan. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}
/**
 * 输入框提示文字颜色
 **/
+(UIColor *)placeholderColor{
     return [UIColor colorWithHex:0x878788 alpha:1.0];
}

/**
 * 创建直播界面 Label 标题颜色
 **/
+(UIColor *)liveLabelTilteColor{
    return [UIColor colorWithHex:0x878788 alpha:1.0];
}
/**
 * 全局字体颜色
 **/
+(UIColor *)baseFontColor{
    return [UIColor colorWithHex:0x4d4d4d alpha:1.0];
}
/**
 * 边框颜色
 **/
+(UIColor *)borderColor{
    return [UIColor colorWithHex:0xcacaca alpha:1.0];
}
/**
 * app 主色调
 */
+ (UIColor*)mainColor{

    return [UIColor colorWithHex:0xff3c6f alpha:1.0];
}

/**
 * app button 高亮颜色
 */
+ (UIColor*)bottonHightColor{
    
    return [UIColor colorWithHex:0xd43572 alpha:1.0];
}

/**
 * app 导航颜色
 */
+ (UIColor*)navColor{

    return [UIColor colorWithHex:0xF9f9f9];
}
/**
 * app 导航分隔线颜色
 */
+ (UIColor*)navLineColor{

    return [UIColor colorWithHex:0xebebeb];
}
/**
 * app 白色的底的时候 分割线的颜色
 */
+ (UIColor*)whiteBackgroundWithLineColor{
    
    return [UIColor colorWithHex:0xdfdfdf];
}
/**
 * app 导航title 字体颜色
 */
+ (UIColor*)navTitleColor{

    return [UIColor colorWithHex:0x000000];
}
/**
 * app 所有视图的背景颜色
 */
+(UIColor *)backgroundColor{
     return [UIColor colorWithHex:0xf3f3f3];
}

+ (UIColor*) colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (NSString *) hexFromUIColor: (UIColor*) color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%x%x%x", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}



@end
