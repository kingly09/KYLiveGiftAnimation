//
//  MZGiftModel.h
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
#import "MZUserInfo.h"

typedef NS_ENUM(NSInteger, GIFT_TYPE) {
    GIFT_TYPE_DEFAULT    = 0,     //（默认）普通左边动画
    GIFT_TYPE_MASK       = 1,     //贵族面具
    GIFT_TYPE_OCEAN      = 2,     //海洋之星
    GIFT_TYPE_GUARD      = 3,     //爱心守护者
    GIFT_TYPE_COOFFEE    = 4,     //咖啡印记
    GIFT_TYPE_CASTLE     = 5,      //女皇的城堡
    GIFT_TYPE_BURSTS     = 6       //连发动画
};

@protocol MZGiftModel <NSObject>

@end

@interface MZGiftModel : NSObject

@property (nonatomic,assign) long giftId;              // 礼物的id
@property (nonatomic,copy) NSString *giftName;         // 礼物名称
@property (nonatomic,copy) NSString *giftPic;          // 礼物图片
@property (nonatomic)  enum GIFT_TYPE giftType;        // 礼物类型
@property (nonatomic,assign)  NSInteger sort;          // 礼物的排序
@property (nonatomic,assign) double giftPrice;         // 礼物价格

@property (nonatomic,strong) MZUserInfo *user;     // 送礼者
@property (nonatomic,assign) NSInteger giftCount;  // 礼物个数

/// 自定义属性
@property (nonatomic,strong) UIImage *headImage; // 头像
@property (nonatomic,strong) UIImage *giftImage; // 礼物图像

@end
