//
//  MZBaseAnimView.h
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
#import "MZShakeLabel.h"
#import "MZGiftModel.h"


typedef void(^completeBlock)(BOOL finished,NSInteger finishCount);

@interface MZBaseAnimView : UIView


@property (nonatomic,strong) MZGiftModel *model;
@property (nonatomic,strong) UIImageView *userInfoAnimView;   //用户信息动画
@property (nonatomic,assign) NSInteger giftCount; // 礼物个数
@property (nonatomic,strong) UILabel *nameLabel; // 送礼物者
@property (nonatomic,strong) UILabel *giftLabel; // 礼物名称
@property (nonatomic,strong) MZShakeLabel *skLabel;
@property (nonatomic,assign) NSInteger animCount; // 动画执行到了第几次
@property (nonatomic,assign) CGRect originFrame; // 记录原始坐标

// 新增了回调参数 finishCount， 用来记录动画结束时累加数量，将来在几秒内，还能继续累加
@property (nonatomic,copy) void(^completeBlock)(BOOL finished,NSInteger finishCount); 

// 动画是否完成
@property (nonatomic,assign,getter=isFinished) BOOL finished;

/// 初始化自定义动画
-(void)setupCustomView;

/// 初始化公共自定义动画
-(void)pubicView;

/// 动画完成后的回调
- (void)animateWithCompleteBlock:(completeBlock)completed;

/// 显示 x 礼物的数量动画
- (void)shakeNumberLabel;

/// 隐藏当前动画视图
- (void)hideCurretView;

/// 重置当前视图的frame
- (void)resetframe;


/// 取一个随机整数，范围在[from,to），包括from，包括to
-(int)getRandomNumber:(int)from to:(int)to;

/// 初始化用户打赏信息 
-(void)setupUserInfoAnimView:(MZGiftModel *)model;

// 执行用户打赏信息动画
-(void)showUserInfoAinm;

@end
