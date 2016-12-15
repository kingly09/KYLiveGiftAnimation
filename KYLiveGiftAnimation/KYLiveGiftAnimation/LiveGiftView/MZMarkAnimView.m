//
//  MZMarkAnimView.m
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

#import "MZMarkAnimView.h"
#import "MZLiveGiftAnimationHeader.h"

#define KMarkImageViewWidth 205
#define KMarkImageViewHight 260 

#define KblueboomAnimViewHight 350
#define KblueboomAnimViewHightFooterSpace  152

#define KFeather1MaskAnimViewWidth 305
#define KFeather1MaskAnimViewHigth 101.5
#define KFeather1MaskAnimViewHigthTopSpace  158.5
#define KFeather1MaskAnimViewRightSpace  13.5

#define KFeather2MaskAnimViewWidth 311.5
#define KFeather2MaskAnimViewHigth 106.5
#define KFeather2MaskAnimViewHigthTopSpace  162.5
#define KFeather2MaskAnimViewLeftSpace  50

@interface MZMarkAnimView ()

@property (nonatomic,strong) UIImageView *markImageView;      //面具动画
@property (nonatomic,strong) UIImageView *markboomAnimView;   //烟雾动画

@property (nonatomic,strong) UIImageView *feather1MaskAnimView; //羽毛01
@property (nonatomic,strong) UIImageView *feather2MaskAnimView; //羽毛02

@end

@implementation MZMarkAnimView

- (instancetype)init {
    if (self = [super init]) {
       
    }
    return self;
}

-(void)setupCustomView{


    //面具
    _markImageView = [[UIImageView alloc] init];   
    _markboomAnimView  =  [[UIImageView alloc] init];

     //羽毛
    _feather1MaskAnimView = [[UIImageView alloc]  init];
    _feather2MaskAnimView = [[UIImageView alloc] init];

    [self addSubview:_markImageView];
    [self addSubview:_markboomAnimView];
    [self addSubview:_feather1MaskAnimView];
    [self addSubview:_feather2MaskAnimView];
    
}

#pragma mark - 对外接口
- (void)setModel:(MZGiftModel *)model {

    //烟雾
    _markboomAnimView.frame = CGRectMake(0,SCREEN_HEIGHT - KblueboomAnimViewHight - KblueboomAnimViewHightFooterSpace,SCREEN_WIDTH,KblueboomAnimViewHight);
    
     //面具       
    _markImageView.frame = CGRectMake((SCREEN_WIDTH - KMarkImageViewWidth)/2,0, KMarkImageViewWidth, KMarkImageViewHight);
    _markImageView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_mask_bigger_14th"];
    _markImageView.hidden = YES;
    
     //羽毛01
    _feather1MaskAnimView.frame = CGRectMake(SCREEN_WIDTH - KFeather1MaskAnimViewWidth - KFeather1MaskAnimViewRightSpace,KFeather1MaskAnimViewHigthTopSpace, KFeather1MaskAnimViewWidth, KFeather1MaskAnimViewHigth);
    _feather1MaskAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_feather1_mask_14th"];
    _feather1MaskAnimView.hidden = YES;
    
    //羽毛02
    _feather2MaskAnimView.frame = CGRectMake(SCREEN_WIDTH - KFeather2MaskAnimViewWidth - KFeather2MaskAnimViewLeftSpace,KFeather2MaskAnimViewHigthTopSpace, KFeather2MaskAnimViewWidth, KFeather2MaskAnimViewHigth);
    _feather2MaskAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_feather2_mask_14th"];
    _feather2MaskAnimView.hidden = YES;
    
    //礼物数量
    self.skLabel.frame = CGRectMake(SCREEN_WIDTH - KLiveShakeLabelWidth - 15 ,199, KLiveShakeLabelWidth, KLiveShakeLabelHight);
  
    //初始化用户打赏信息
    [self setupUserInfoAnimView:model];

}

- (void)animateWithCompleteBlock:(completeBlock)completed{
  
  //烟雾效果
  [self startPurpleboomAnimView];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
      [self showMarkImageViewAinm];
      [self showFeatherAinm];
      
    } completion:^(BOOL finished) {
      
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //用户打赏动画
          [self showUserInfoAinm]; 
        });  
    }];
  });
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self shakeNumberLabel];
  });
  

  self.completeBlock = completed;

}

/**
 面具动画
 */
-(void)showMarkImageViewAinm{     
  _markImageView.hidden = NO;
  _markImageView.alpha = 0;
  [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations:^{
        _markImageView.alpha = 1;
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/2.0 animations:^{
            
            _markImageView.transform = CGAffineTransformMakeScale(3, 3);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations:^{
            
            _markImageView.transform = CGAffineTransformMakeScale(1, 1);
        }];
        
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _markImageView.alpha = 1;
                _markImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:nil];
        }];
}

/**
 显示羽毛动画
 */
-(void)showFeatherAinm{
   
   _feather1MaskAnimView.hidden = NO;
   [UIView upDownAnimation:_feather1MaskAnimView  withAnimUpToDownHight:KAnimUpToDownHight withDuration:1 withRepeatCount:HUGE_VALF];
   
   _feather2MaskAnimView.hidden = NO;
   [UIView downUpAnimation:_feather2MaskAnimView  withAnimUpToDownHight:KAnimUpToDownHight withDuration:1 withRepeatCount:HUGE_VALF];
   
}

/**
 烟雾动画
 */
-(void)startPurpleboomAnimView{
  NSArray *magesArray = [NSArray arrayWithObjects:
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_1"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_2"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_3"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_4"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_5"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_6"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_7"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_8"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_9"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_10"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_11"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Purpleboom_12"],nil];
  _markboomAnimView.animationImages = magesArray;//将序列帧数组赋给UIImageView的animationImages属性
  _markboomAnimView.animationDuration = 0.6;//设置动画时间
  _markboomAnimView.animationRepeatCount = 1;//设置动画次数 0 表示无限
  [_markboomAnimView startAnimating];//开始播放动画    
  
  //延时结束刷新
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [_markboomAnimView stopAnimating];
    _markboomAnimView.alpha = 0;
    [_markboomAnimView removeFromSuperview];
  });


}

@end
