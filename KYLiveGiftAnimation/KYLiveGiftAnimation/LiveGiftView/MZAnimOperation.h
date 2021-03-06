//
//  MZAnimOperation.h
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

#import <UIKit/UIKit.h>
#import "MZPresentView.h"
#import "MZGiftModel.h"

#import "MZRightAnimView.h" 
#import "MZOceanAnimView.h"
#import "MZCastleAnimView.h"
#import "MZMarkAnimView.h"


typedef NS_ENUM(NSInteger, GIFT_INDEX) {
    GIFT_INDEX_queue1          = 1,     //普通队列1
    GIFT_INDEX_queue2          = 2,     //普通队列2
    GIFT_INDEX_queue3          = 3,     //普通队列3
    
    GIFT_INDEX_rightQueue      = 4,     //爱心守护者和咖啡印记 队列
    GIFT_INDEX_markQueue       = 5,     //贵族面具队列
    GIFT_INDEX_oceanQueue      = 6,     //海洋之星队列
    GIFT_INDEX_castleQueue     = 7      //女皇的城堡队列
};

@interface MZAnimOperation : NSOperation

@property (nonatomic,strong) MZPresentView *presentView;
@property (nonatomic,strong) UIView *listView;

@property (nonatomic,strong) MZRightAnimView *rightAnimView;  //右边动画
@property (nonatomic,strong) UIView *rightAnimlistView;

@property (nonatomic,strong) MZOceanAnimView *oceanAnimView;  //海洋之星动画
@property (nonatomic,strong) UIView *oceanAnimlistView;

@property (nonatomic,strong) MZCastleAnimView *castleAnimView;  //女皇的城堡动画
@property (nonatomic,strong) UIView *castleAnimlistView;

@property (nonatomic,strong) MZMarkAnimView *markAnimView;      //贵族面具动画
@property (nonatomic,strong) UIView *markAnimlistView;

@property (nonatomic,strong) MZGiftModel *model;
@property (nonatomic)  enum  GIFT_INDEX index;  //属于那个队列 


// 回调参数增加了结束时礼物累计数 
+ (instancetype)animOperationWithGiftModel:(MZGiftModel *)model finishedBlock:(void(^)(BOOL result,NSInteger finishCount))finishedBlock;



@end
