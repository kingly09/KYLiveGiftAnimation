//
//  UIView+animate.h
//  KYLiveGiftAnimation
//
//  Created by kingly on 2016/12/13.
//  Copyright © 2016年 KYLiveGiftAnimation   Software (https://github.com/kingly09/KYLiveGiftAnimation) by kingly inc.  

//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (animate)

/**
 从上往下浮动 无限重复

 @param upDownAnimationView 动画的视图
 @param animUpToDownHight 浮动的高度
 */
+(void)upDownAnimation:(UIView *)upDownAnimationView withAnimUpToDownHight:(float )animUpToDownHight;

/**
 从上往下浮动

 @param upDownAnimationView 动画的视图
 @param animUpToDownHight 浮动的高度
 @param duration 动画的时间
 @param repeatCount 重复的次数
 */
+(void)upDownAnimation:(UIView *)upDownAnimationView withAnimUpToDownHight:(float )animUpToDownHight withDuration:(float)duration withRepeatCount:(float)repeatCount;

/**
 从下往上浮动 无限重复
 
 @param animationView 动画的视图
 @param animUpToDownHight 浮动的高度
 */
+(void)downUpAnimation:(UIView *)animationView withAnimUpToDownHight:(float )animUpToDownHight;

/**
 从下往上浮动

 @param animationView 动画的视图
 @param animUpToDownHight 浮动的高度
 @param duration 动画的时间
 @param repeatCount 重复的次数
 */
+(void)downUpAnimation:(UIView *)animationView withAnimUpToDownHight:(float )animUpToDownHight withDuration:(float)duration withRepeatCount:(float)repeatCount;

/**
 闪动画

 @param opacityAnimationView  需要闪的动画
 */
+(void)opacityAnimation:(UIView *)opacityAnimationView;

/**
 闪动画

 @param opacityAnimationView 闪动画
 @param duration 闪动画的时间
 */
+(void)opacityAnimation:(UIView *)opacityAnimationView withDuration:(float )duration;

@end
