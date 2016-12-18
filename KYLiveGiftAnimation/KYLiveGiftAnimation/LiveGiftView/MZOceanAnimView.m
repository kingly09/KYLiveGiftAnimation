//
//  MZOceanAnimView.m
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

#import "MZOceanAnimView.h"
#import "MZLiveGiftAnimationHeader.h"

#define KLeftImageViewHerSpace 265.5
#define KLeftImageViewWidth  53.5
#define KLeftImageViewHight  127

#define KRightImageViewHerSpace 298.5
#define KRightImageViewWidth 58.5
#define KRightImageViewHight 124
#define KRightImageViewWidthOriginX  (SCREEN_WIDTH - KRightImageViewWidth)

#define KLeftDownAnimViewWidth 181.5
#define KLeftDownAnimViewHight 179
#define KLeftDownAnimViewHightFooterSpace  (27.5 - KAnimUpToDownHight) 

#define KRightDownAnimViewWidth 276.5
#define KRightDownAnimViewHight 257
#define KRightDownAnimViewHightFooterSpace  27.5 

#define KLeftBackAnimViewWidth 193
#define KLeftBackAnimViewHight 188
#define KLeftBackAnimViewWidthSpace 37.0
#define KLeftBackAnimViewHightFooterSpace  160 


#define KRightBackAnimViewWidth 146.9
#define KRightBackAnimViewHight 143
#define KRightBackAnimViewWidthSpace 70
#define KRightBackAnimViewHightFooterSpace  130

#define KShipAnimViewWidth 178.5
#define KShipAnimViewHight 181.5
#define KShipAnimViewWidthSpace 60
#define KShipAnimViewHightFooterSpace  120

#define KblueboomAnimViewHight 350
#define KblueboomAnimViewHightFooterSpace  152

#define KbigStarImageViewWidth 278
#define KbigStarImageViewHight 282
#define KbigStarImageViewHightTopSpace 9


#define KBigStarWidth 45
#define KSmallStarWidth 25

#define KLeftStarAnimViewSpace 10
#define KLeftSmallStarAnimViewSpace 55

#define KLeftSmallStarAnimViewTopSpace 100
#define KRigthSmallStarAnimViewTopSpace 125
#define KRigthSmallStarAnimViewRightSpace  55

#define KStarTopVarSpace 30 //小星星 动画开始位置

@interface MZOceanAnimView ()

@property (nonatomic,strong) UIImageView *leftImageView;      //左边视图
@property (nonatomic,strong) UIImageView *leftStarAnimView;   //左边星星

@property (nonatomic,strong) UIImageView *rightImageView;     //右边视图
@property (nonatomic,strong) UIImageView *rightStarAnimView;  //右边星星

@property (nonatomic,strong) UIImageView *bigStarImageView;        //中间大星星
@property (nonatomic,strong) UIImageView *smallLeftStarAnimView;       //中间大星星的左边星星
@property (nonatomic,strong) UIImageView *smallRightStarAnimView;    //中间大星星的左边星星

@property (nonatomic,strong) UIImageView *leftDownAnimView;   //左下角动画
@property (nonatomic,strong) UIImageView *rightDownAnimView;  //右下角动画
@property (nonatomic,strong) UIImageView *leftBackAnimView;   //左后动画
@property (nonatomic,strong) UIImageView *rightBackAnimView;  //右后动画
@property (nonatomic,strong) UIImageView *shipAnimView;       //海盗船动画

@property (nonatomic,strong) UIImageView *blueboomAnimView;   //烟雾动画

@end

@implementation MZOceanAnimView

- (instancetype)init {
    if (self = [super init]) {
   
    }
    return self;
}

-(void)setupCustomView{

    _leftImageView = [[UIImageView alloc] init];
    _leftStarAnimView = [[UIImageView alloc] init];
    
    _rightImageView    = [[UIImageView alloc] init];
    _rightStarAnimView = [[UIImageView alloc] init];
    
    _leftDownAnimView  = [[UIImageView alloc] init];
    _rightDownAnimView = [[UIImageView alloc] init];
    
    _leftBackAnimView  =  [[UIImageView alloc] init];
    _rightBackAnimView =  [[UIImageView alloc] init];
    _shipAnimView      =  [[UIImageView alloc] init];
    _blueboomAnimView  =  [[UIImageView alloc] init];
    
    _bigStarImageView  = [[UIImageView alloc] init];

    _smallLeftStarAnimView = [[UIImageView alloc] init];
    _smallRightStarAnimView = [[UIImageView alloc] init];

    
    [self addSubview:_bigStarImageView];
    [self addSubview:_smallLeftStarAnimView];
    [self addSubview:_smallRightStarAnimView];
    

    [self addSubview:_leftImageView];
    [self addSubview:_leftStarAnimView];
    
    [self addSubview:_rightImageView];
    [self addSubview:_rightStarAnimView];
    
    [self addSubview:_leftBackAnimView];
    [self addSubview:_rightBackAnimView];
    [self addSubview:_shipAnimView];

   
    [self addSubview:_rightDownAnimView];
    [self addSubview:_leftDownAnimView];
    [self addSubview:_blueboomAnimView];
   

}

#pragma mark - 对外接口
- (void)setModel:(MZGiftModel *)model {
    
    //发光的星星
    _bigStarImageView.frame = CGRectMake((SCREEN_WIDTH-KbigStarImageViewWidth)/2 ,-KbigStarImageViewHight, KbigStarImageViewWidth, KbigStarImageViewHight);
    
    //左边的小星星
    _smallLeftStarAnimView.frame = CGRectMake(KLeftSmallStarAnimViewSpace,KStarTopVarSpace, KSmallStarWidth, KSmallStarWidth);
    _smallLeftStarAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_start_2_z_14th"];

     //右边的小星星
    _smallRightStarAnimView.frame = CGRectMake(SCREEN_WIDTH - KSmallStarWidth - KRigthSmallStarAnimViewRightSpace,KStarTopVarSpace, KSmallStarWidth, KSmallStarWidth);
    _smallRightStarAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_start_2_z_14th"];

                   
    //左后海浪
    _leftBackAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_wave_Back_L_14th"];
    _leftBackAnimView.frame = CGRectMake(KLeftBackAnimViewWidthSpace,SCREEN_HEIGHT, KLeftBackAnimViewWidth, KLeftBackAnimViewHight);
     
    //右后海浪
    _rightBackAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_wave_Back_R_14th"];
    _rightBackAnimView.frame = CGRectMake(SCREEN_WIDTH-(KRightBackAnimViewWidthSpace+KRightBackAnimViewWidth),SCREEN_HEIGHT, KRightBackAnimViewWidth, KRightBackAnimViewHight);
     
    //海盗船
    _shipAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_boat_14th"];
    _shipAnimView.frame = CGRectMake(KShipAnimViewWidthSpace,SCREEN_HEIGHT, KShipAnimViewWidth, KShipAnimViewHight);
    
    //烟雾
    _blueboomAnimView.frame = CGRectMake(0,SCREEN_HEIGHT - KblueboomAnimViewHight - KblueboomAnimViewHightFooterSpace,SCREEN_WIDTH,KblueboomAnimViewHight);
    
     
    //左海浪
    _leftImageView.image   = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_wave_L_14th"];
    _leftImageView.frame = CGRectMake(-KLeftImageViewWidth,SCREEN_HEIGHT-KLeftImageViewHight-KLeftImageViewHerSpace, KLeftImageViewWidth, KLeftImageViewHight);
    
    // 左海浪旁边的星星
    _leftStarAnimView.frame = CGRectMake(KLeftStarAnimViewSpace,KStarTopVarSpace, KBigStarWidth, KBigStarWidth);
    _leftStarAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_start_2_z_14th"];

  
    //右海浪
    _rightImageView.image  = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_wave_R_14th"];
    _rightImageView.frame = CGRectMake(SCREEN_WIDTH,SCREEN_HEIGHT-KRightImageViewHight-KRightImageViewHerSpace, KRightImageViewWidth, KRightImageViewHight);
    
    // 右海浪旁边的星星
    _rightStarAnimView.frame = CGRectMake(SCREEN_WIDTH - KLeftStarAnimViewSpace*2 -KBigStarWidth ,KStarTopVarSpace, KBigStarWidth, KBigStarWidth);
    _rightStarAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_start_2_z_14th"];

    
    //海浪-前左（上下浮动）
    _leftDownAnimView.frame = CGRectMake(0,SCREEN_HEIGHT, KLeftDownAnimViewWidth, KLeftDownAnimViewHight);
    _leftDownAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_wave_Front_L_14th"];
    
    //海浪-前右（上下浮动）
    _rightDownAnimView.frame = CGRectMake(SCREEN_WIDTH - KRightDownAnimViewWidth,SCREEN_HEIGHT, KRightDownAnimViewWidth, KRightDownAnimViewHight);
    _rightDownAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_wave_Front_R_14th"];
    
    //初始化用户打赏信息
    self.skLabel.frame = CGRectMake(SCREEN_WIDTH - KLiveShakeLabelWidth - 30 ,KbigStarImageViewHightTopSpace + KbigStarImageViewHight*2/3 - 60, KLiveShakeLabelWidth, KLiveShakeLabelHight);
  
    [self setupUserInfoAnimView:model];

}

- (void)animateWithCompleteBlock:(completeBlock)completed{

  
  //发光的星星
  [self shiningStarAinmView];

  //星星旋转
  [self startRotationAnimView];
  //烟雾动画
  [self startBlueboomAnimView];
  
  [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
     
      _leftImageView.frame   = CGRectMake(0,_leftImageView.frame.origin.y, KLeftImageViewWidth, KLeftImageViewHight);
      _rightImageView.frame  = CGRectMake(SCREEN_WIDTH-KRightImageViewWidth,_rightImageView.frame.origin.y, KRightImageViewWidth, KRightImageViewHight);
    
      //底部海浪与船
      _leftBackAnimView.frame  = CGRectMake(_leftBackAnimView.frame.origin.x,SCREEN_HEIGHT-KLeftBackAnimViewHight-KLeftBackAnimViewHightFooterSpace, KLeftBackAnimViewWidth, KLeftBackAnimViewHight);
      _rightBackAnimView.frame = CGRectMake(_rightBackAnimView.frame.origin.x,SCREEN_HEIGHT-KRightBackAnimViewHight-KRightBackAnimViewHightFooterSpace, KRightBackAnimViewWidth, KRightBackAnimViewHight);
      _shipAnimView.frame      = CGRectMake(_shipAnimView.frame.origin.x,SCREEN_HEIGHT-KShipAnimViewHight-KShipAnimViewHightFooterSpace , KShipAnimViewWidth, KShipAnimViewHight);
      _leftDownAnimView.frame  = CGRectMake(0,SCREEN_HEIGHT-KLeftDownAnimViewHight-KLeftDownAnimViewHightFooterSpace, KLeftDownAnimViewWidth, KLeftDownAnimViewHight);
      _rightDownAnimView.frame = CGRectMake(_rightDownAnimView.frame.origin.x,SCREEN_HEIGHT - KRightDownAnimViewHight - KRightDownAnimViewHightFooterSpace, KRightDownAnimViewWidth, KRightDownAnimViewHight);
    
   } completion:^(BOOL finished) {
   
  
      [UIView upDownAnimation:self.leftBackAnimView  withAnimUpToDownHight:KAnimUpToDownHight];
      [UIView downUpAnimation:self.rightBackAnimView withAnimUpToDownHight:KAnimUpToDownHight];
      [UIView downUpAnimation:self.shipAnimView      withAnimUpToDownHight:KAnimUpToDownHight*3 withDuration:1 withRepeatCount:HUGE_VALF];
      [UIView downUpAnimation:self.leftDownAnimView  withAnimUpToDownHight:KAnimUpToDownHight withDuration:1 withRepeatCount:HUGE_VALF];
      [UIView upDownAnimation:self.rightDownAnimView withAnimUpToDownHight:KAnimUpToDownHight*2 withDuration:2 withRepeatCount:HUGE_VALF];
       
      //用户打赏动画
      [self showUserInfoAinm]; 
  }];
  
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self shakeNumberLabel];
  });
  

  self.completeBlock = completed;

}

//发光的星星动画效果
-(void)shiningStarAinmView{

  [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
     _bigStarImageView.frame = CGRectMake(_bigStarImageView.frame.origin.x ,KbigStarImageViewHightTopSpace, KbigStarImageViewWidth, KbigStarImageViewHight);
     _smallLeftStarAnimView.frame = CGRectMake(_smallLeftStarAnimView.frame.origin.x,KLeftSmallStarAnimViewTopSpace, KSmallStarWidth, KSmallStarWidth);
     _smallRightStarAnimView.frame = CGRectMake(_smallRightStarAnimView.frame.origin.x,KRigthSmallStarAnimViewTopSpace, KSmallStarWidth, KSmallStarWidth);
     _leftStarAnimView.frame = CGRectMake(KLeftStarAnimViewSpace,_leftImageView.frame.origin.y, KBigStarWidth, KBigStarWidth);
     _rightStarAnimView.frame = CGRectMake(_rightStarAnimView.frame.origin.x ,_rightImageView.frame.origin.y, KBigStarWidth, KBigStarWidth);
    
    NSArray *magesArray = [NSArray arrayWithObjects:
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_shiningstar_1_14th"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_shiningstar_2_14th"],nil];
  _bigStarImageView.animationImages = magesArray;//将序列帧数组赋给UIImageView的animationImages属性
  _bigStarImageView.animationDuration = 0.2;//设置动画时间
  _bigStarImageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
  [_bigStarImageView startAnimating];//开始播放动画    
  
  } completion:^(BOOL finished) {
  
     [self startRotationAnimView];
  }];

}

// 4个小星星 动画
-(void)startRotationAnimView{

    int minRotion = 30;
    int maxRotion = 120;

    _smallLeftStarAnimView.transform = CGAffineTransformMakeRotation([self getRandomNumber:minRotion to:maxRotion]*M_PI/180);
    _smallRightStarAnimView.transform = CGAffineTransformMakeRotation([self getRandomNumber:minRotion to:maxRotion]*M_PI/180);
   _leftStarAnimView.transform = CGAffineTransformMakeRotation([self getRandomNumber:minRotion to:maxRotion]*M_PI/180);
   _rightStarAnimView.transform = CGAffineTransformMakeRotation([self getRandomNumber:minRotion to:maxRotion]*M_PI/180);
   
   [UIView opacityAnimation:_smallLeftStarAnimView];
   [UIView opacityAnimation:_smallRightStarAnimView];
   [UIView opacityAnimation:_leftStarAnimView];
   [UIView opacityAnimation:_rightStarAnimView];
   
}

/**
 烟雾动画
 */
-(void)startBlueboomAnimView{
  NSArray *magesArray = [NSArray arrayWithObjects:
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_1"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_2"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_3"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_4"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_5"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_6"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_7"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_8"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_9"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_10"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_11"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Blueboom_12"],nil];
  _blueboomAnimView.animationImages = magesArray;//将序列帧数组赋给UIImageView的animationImages属性
  _blueboomAnimView.animationDuration = 0.6;//设置动画时间
  _blueboomAnimView.animationRepeatCount = 1;//设置动画次数 0 表示无限
  [_blueboomAnimView startAnimating];//开始播放动画    
  
  //延时结束刷新
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [_blueboomAnimView stopAnimating];
    _blueboomAnimView.alpha = 0;
    [_blueboomAnimView removeFromSuperview];
  });

}




@end
