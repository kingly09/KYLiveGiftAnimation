//
//  UIView+animate.m
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

#import "UIView+animate.h"

@implementation UIView(animate)

// 上下浮动 无限浮动
+(void)upDownAnimation:(UIView *)upDownAnimationView withAnimUpToDownHight:(float )animUpToDownHight{
    [self upDownAnimation:upDownAnimationView withAnimUpToDownHight:animUpToDownHight withDuration:0.5 withRepeatCount:HUGE_VALF];
}
// 上下浮动
+(void)upDownAnimation:(UIView *)upDownAnimationView withAnimUpToDownHight:(float )animUpToDownHight withDuration:(float)duration withRepeatCount:(float)repeatCount;
{

  CAKeyframeAnimation *upDownAnimation;
   upDownAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
   upDownAnimation.values = @[@(upDownAnimationView.layer.position.y), @(upDownAnimationView.layer.position.y + animUpToDownHight),@(upDownAnimationView.layer.position.y)];
   upDownAnimation.duration = duration;
   upDownAnimation.fillMode = kCAFillModeBoth;
   upDownAnimation.calculationMode = kCAAnimationCubic;
   upDownAnimation.repeatCount = repeatCount;
  [upDownAnimationView.layer addAnimation:upDownAnimation forKey:@"upDownAnimation"];

}

+(void)downUpAnimation:(UIView *)animationView withAnimUpToDownHight:(float )animUpToDownHight{
    [self downUpAnimation:animationView withAnimUpToDownHight:animUpToDownHight withDuration:0.5 withRepeatCount:HUGE_VALF];
}
// 下上浮动
+(void)downUpAnimation:(UIView *)animationView withAnimUpToDownHight:(float )animUpToDownHight withDuration:(float)duration withRepeatCount:(float)repeatCount{

  CAKeyframeAnimation *downUpAnimation;
   downUpAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
   downUpAnimation.values = @[@(animationView.layer.position.y), @(animationView.layer.position.y - animUpToDownHight),@(animationView.layer.position.y)];
   downUpAnimation.duration = duration;
   downUpAnimation.fillMode = kCAFillModeBoth;
   downUpAnimation.calculationMode = kCAAnimationCubic;
   downUpAnimation.repeatCount = repeatCount;
  [animationView.layer addAnimation:downUpAnimation forKey:@"downUpAnimation"];

}

+(void)opacityAnimation:(UIView *)opacityAnimationView{

    [self opacityAnimation:opacityAnimationView withDuration:0.5];
}

+(void)opacityAnimation:(UIView *)opacityAnimationView withDuration:(float )duration{

    CAKeyframeAnimation *opacityAnimation;
    opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@(1), @(0.6), @(1)];
    opacityAnimation.duration = duration;
    opacityAnimation.fillMode = kCAFillModeBoth;
    opacityAnimation.calculationMode = kCAAnimationCubic;
    opacityAnimation.repeatCount = HUGE_VALF;
    [opacityAnimationView.layer addAnimation:opacityAnimation forKey:@"opacityAnimation"];

}

@end
