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

@interface MZOceanAnimView ()
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,copy) void(^completeBlock)(BOOL finished,NSInteger finishCount); // 新增了回调参数 finishCount， 用来记录动画结束时累加数量，将来在3秒内，还能继续累加

@property (nonatomic,strong) UIImageView *leftImageView;      //左边视图
@property (nonatomic,strong) UIImageView *leftStarAnimView;   //左边星星

@property (nonatomic,strong) UIImageView *rightImageView;     //右边视图
@property (nonatomic,strong) UIImageView *rightStarAnimView;  //右边星星

@property (nonatomic,strong) UIImageView *bigStarImageView;        //中间大星星
@property (nonatomic,strong) UIImageView *smallStarAnimView;       //中间大星星的左边星星
@property (nonatomic,strong) UIImageView *bigRightStarAnimView;    //中间大星星的左边星星

@property (nonatomic,strong) UIImageView *leftDownAnimView;   //左下角动画

@property (nonatomic,strong) UIImageView *rightDownAnimView;  //右下角动画
@property (nonatomic,strong) UIImageView *middleAnimView;     //中间动画


@property (nonatomic,strong) UIImageView *shipAnimView;       //海盗船动画
@property (nonatomic,strong) UIImageView *userInfoAnimView;   //用户信息动画


@end

@implementation MZOceanAnimView

- (instancetype)init {
    if (self = [super init]) {
        _originFrame = self.frame;
        [self setupCustomView];
    }
    return self;
}

-(void)setupCustomView{

    _leftImageView = [[UIImageView alloc] init];
    _rightImageView = [[UIImageView alloc] init];
    
    _leftDownAnimView  = [[UIImageView alloc] init];
    _rightDownAnimView = [[UIImageView alloc] init];

    _nameLabel = [[UILabel alloc] init];
    _giftLabel = [[UILabel alloc] init];
    
    _nameLabel.textColor  = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    
    _giftLabel.textColor  = [UIColor colorWithHex:0x00eaff];
    _giftLabel.font = [UIFont systemFontOfSize:12];
    
    // 初始化动画label
    _skLabel =  [[MZShakeLabel alloc] init];
    _skLabel.font = [UIFont systemFontOfSize:25];
    _skLabel.borderColor = [UIColor whiteColor];
    _skLabel.textColor = [UIColor colorWithHex:0xff3c6f];
    _skLabel.textAlignment = NSTextAlignmentLeft;
    _animCount = 0;
    
    [self addSubview:_skLabel];
    [self addSubview:_leftImageView];
    [self addSubview:_rightImageView];
    
    
    [self addSubview:_leftDownAnimView];
    [self addSubview:_rightDownAnimView];
    

}

#pragma mark - 对外接口
- (void)setModel:(MZGiftModel *)model {

  if (_model != model) {
    _model = nil;
    _model = model;
     
     //左海浪
    _leftImageView.image   = [UIImage imageNamed:@"ic_wave_L_14th"];
    _leftImageView.frame = CGRectMake(-KLeftImageViewWidth,SCREEN_HEIGHT-KLeftImageViewHight-KLeftImageViewHerSpace, KLeftImageViewWidth, KLeftImageViewHight);
    
    //右海浪
    _rightImageView.image  = [UIImage imageNamed:@"ic_wave_R_14th"];
    _rightImageView.frame = CGRectMake(SCREEN_WIDTH,SCREEN_HEIGHT-KRightImageViewHight-KRightImageViewHerSpace, KRightImageViewWidth, KRightImageViewHight);
    
    //海浪-前左（上下浮动）
    _leftDownAnimView.frame = CGRectMake(0,SCREEN_HEIGHT-KLeftDownAnimViewHight-KLeftDownAnimViewHightFooterSpace, KLeftDownAnimViewWidth, KLeftDownAnimViewHight);
    _leftDownAnimView.image = [UIImage imageNamed:@"ic_wave_Front_L_14th"];
    
    //海浪-前右（上下浮动）
    _rightDownAnimView.frame = CGRectMake(SCREEN_WIDTH - KRightDownAnimViewWidth,SCREEN_HEIGHT - KRightDownAnimViewHight - KRightDownAnimViewHightFooterSpace, KRightDownAnimViewWidth, KRightDownAnimViewHight);
    _rightDownAnimView.image = [UIImage imageNamed:@"ic_wave_Front_R_14th"];
    
  
    _skLabel.frame = CGRectMake(0,self.frame.size.height-KLiveShakeLabelHight, KLiveShakeLabelWidth, KLiveShakeLabelHight);
    
    _nameLabel.text = model.userName;
    _giftLabel.text = [NSString stringWithFormat:@"送出【%@】",model.giftName];
    _giftCount = model.giftCount;
    
    
  }
}

- (void)animateWithCompleteBlock:(completeBlock)completed{


  [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
   
      _leftImageView.frame  = CGRectMake(0,_leftImageView.frame.origin.y, KLeftImageViewWidth, KLeftImageViewHight);
      _rightImageView.frame = CGRectMake(SCREEN_WIDTH-KRightImageViewWidth,_rightImageView.frame.origin.y, KRightImageViewWidth, KRightImageViewHight);
    
     [self downUpAnimation:self.leftDownAnimView];
     [self upDownAnimation:self.rightDownAnimView];
  
  } completion:^(BOOL finished) {
  
  
  }];


  [UIView animateWithDuration:0.5 animations:^{
   

  } completion:^(BOOL finished) {
        [self shakeNumberLabel];
  }];
  
  self.completeBlock = completed;

}
- (void)shakeNumberLabel{
  
   _animCount ++; 
   
   if (_giftCount > 0) {
      _animCount =  _giftCount;
   }
   
   if (_animCount > KLiveShakeLabelMaxNum ) {
      
      _animCount = KLiveShakeLabelMaxNum;
   }

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideCurretView) object:nil];//可以取消成功。
    [self performSelector:@selector(hideCurretView) withObject:nil afterDelay:2];
    
    self.skLabel.text = [NSString stringWithFormat:@"x %ld",_animCount];
    [self.skLabel startAnimWithDuration:0.5];


}

- (void)hideCurretView{
    
     [UIView animateWithDuration:0.30 delay:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.completeBlock) {
            self.completeBlock(finished,_animCount);
        }
        [self resetframe];
        _finished = finished;
        [self removeFromSuperview];
    }];

}

#pragma mark - 私有动画效果

// 上下浮动
-(void)upDownAnimation:(UIView *)upDownAnimationView{

  CAKeyframeAnimation *upDownAnimation;
   upDownAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
   upDownAnimation.values = @[@(upDownAnimationView.layer.position.y), @(upDownAnimationView.layer.position.y + KAnimUpToDownHight),@(upDownAnimationView.layer.position.y)];
   upDownAnimation.duration = 0.5;
   upDownAnimation.fillMode = kCAFillModeBoth;
   upDownAnimation.calculationMode = kCAAnimationCubic;
   upDownAnimation.repeatCount = HUGE_VALF;
  [upDownAnimationView.layer addAnimation:upDownAnimation forKey:@"upDownAnimation"];

}
// 下上浮动
-(void)downUpAnimation:(UIView *)animationView{

  CAKeyframeAnimation *downUpAnimation;
   downUpAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
   downUpAnimation.values = @[@(animationView.layer.position.y), @(animationView.layer.position.y - KAnimUpToDownHight),@(animationView.layer.position.y)];
   downUpAnimation.duration = 0.5;
   downUpAnimation.fillMode = kCAFillModeBoth;
   downUpAnimation.calculationMode = kCAAnimationCubic;
   downUpAnimation.repeatCount = HUGE_VALF;
  [animationView.layer addAnimation:downUpAnimation forKey:@"downUpAnimation"];

}

// 重置
- (void)resetframe {
    self.frame = _originFrame;
    self.alpha = 1;
    self.animCount = 0;
    self.giftCount = 0;
    self.skLabel.text = @"";
}


@end
