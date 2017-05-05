//
//  MZLiveGiftAnimationHeader.h
//  KYLiveGiftAnimation
//
//  Created by kingly on 2016/12/12.
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

#ifndef MZLiveGiftAnimationHeader_h
#define MZLiveGiftAnimationHeader_h

#import "UIColor+CustomColor.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#import "MZGiftModel.h"
#import "MZAnimOperation.h"
#import "MZShakeLabel.h"
#import "MZAnimOperationManager.h"
#import "UIView+animate.h"
#import "MZAnimationImageCache.h"

#import "MZBaseAnimView.h"
#import "MZPresentView.h"
#import "MZRightAnimView.h"
#import "MZOceanAnimView.h"
#import "MZMarkAnimView.h"


#define KLivePresentViewWidth 200.0
#define KLivePresentViewHight 30.0
#define KLivePresentViewWidthSpace 10.0

#define kLiveQueue2FooterSpace 275.0
#define kLiveQueue1OriginY (SCREEN_HEIGHT - kLiveQueue2FooterSpace - KLivePresentViewHight)  - (KLivePresentViewHight + KLivePresentViewWidthSpace)*2
#define kLiveQueue2OriginY (SCREEN_HEIGHT - kLiveQueue2FooterSpace - KLivePresentViewHight)  - (KLivePresentViewHight + KLivePresentViewWidthSpace)
#define kLiveQueue3OriginY (SCREEN_HEIGHT - kLiveQueue2FooterSpace - KLivePresentViewHight)


#define KGiftImageViewWidth 50.0

#define KLiveShakeLabelWidth 70.0 
#define KLiveShakeLabelHight 27.0 

#define KLiveShakeLabelMaxNum 999 //最大数为999

#define KAnimUpToDownHight  10  //所有动画上下往返运动

#define KLiveRightAnimViewWidth  198.0
#define KLiveRightAnimViewHight  56.0
#define KLiveRightAnimViewFooterSpace 253.0
#define KLiveRightAnimViewWidthSpace 12.0
#define KLiveRightAnimViewLabelVarSpace 10.0
#define KLiveRightAnimViewLabelSpace 15.0
#define KLiveRightAnimViewLabelWidth (KLiveRightAnimViewWidth - KLiveRightAnimViewLabelSpace - KLiveRightAnimViewWidthSpace)
#define KLiveRightAnimViewLabelHight (KLiveRightAnimViewHight - KLiveRightAnimViewLabelVarSpace*2)/2
#define KLiveRightAnimViewWidthOriginX  (SCREEN_WIDTH - KLiveRightAnimViewWidth)
#define KLiveRightAnimViewWidthOriginY  (SCREEN_HEIGHT - KLiveRightAnimViewFooterSpace - KLiveRightAnimViewHight)
#define KLiveRightAnimViewShakeNumberLabelVarSpace 15
#define KLiveRightAnimViewLoveWidth 145.0
#define KLiveRightAnimViewLoveHight 110.0

#define KLiveCoffeeCupImageViewWidth 110.0
#define KLiveCoffeeCupImageViewHight 62.0
#define KLiveCoffeeCupImageViewWidthSpace 26.0
#define KLiveCoffeeCupImageViewHightSpace 16.0

//用户打赏动画
#define KAnimNameLabelLeftSPace   55
#define KAnimMameLabelTopSPace    18
#define KAnimNameLabelFooterSPace   12

#define KUserInfoAnimViewWidth  277
#define KUserInfoAnimViewHight  62.5
#define KUserInfoAnimViewHightFooterSpace  333

#endif /* MZLiveGiftAnimationHeader_h */

