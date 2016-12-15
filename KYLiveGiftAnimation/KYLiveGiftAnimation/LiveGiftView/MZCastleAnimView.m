//
//  MZCastleAnimView.m
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

#import "MZCastleAnimView.h"
#import "MZLiveGiftAnimationHeader.h"


#define KblueboomAnimViewHight 350
#define KblueboomAnimViewHightFooterSpace  152


#define KMoonAnimViewWidth 142.5
#define KMoonAnimViewWidthHigth 157.0
#define KMoonAnimViewWidthHigthTopSpace 147.0

#define KCloudRightAnimViewWidth 58
#define KCloudRightAnimViewHight 78.5
#define KCloudRightAnimViewHightTopSpace 225.5

#define KCloudLeftAnimViewWidth 34
#define KCloudLeftAnimViewHight 91
#define KCloudLeftAnimViewHightTopSpace 176.5

#define KCastleAnimViewWidth 308
#define KCastleAnimViewHight 415
#define KCastleAnimViewHightToFooterpSpace 65

#define KCloudUpAnimViewWidth 117
#define KCloudUpAnimViewHight 138
#define KCloudUpAnimViewHightToFooterpSpace 247

#define KCloudDownAnimViewWidth 128
#define KCloudDownAnimViewHight 175
#define KCloudDownAnimViewHightToFooterpSpace 50

#define KCloudFrontAnimViewWidth 273.5
#define KCloudFrontAnimViewHight 179.5
#define KCloudFrontAnimViewHightToFooterpSpace 20


@interface MZCastleAnimView ()

@property (nonatomic,strong) UIImageView *castleboomAnimView;   //烟雾动画

@property (nonatomic,strong) UIImageView *moonAnimView;       //月亮动画
@property (nonatomic,strong) UIImageView *cloudRightAnimView; //树右动画

@property (nonatomic,strong) UIImageView *cloudLeftAnimView; //树左动画

@property (nonatomic,strong) UIImageView *castleAnimView; //城堡动画

@property (nonatomic,strong) UIImageView *cloudUpAnimView; //云上边动画

@property (nonatomic,strong) UIImageView *cloudDownAnimView; //云下边动画

@property (nonatomic,strong) UIImageView *cloudFrontAnimView; //云-前 动画

@end

@implementation MZCastleAnimView

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(void)setupCustomView{
  
    _castleboomAnimView  =  [[UIImageView alloc] init];    
    _moonAnimView = [[UIImageView alloc] init];
    _cloudRightAnimView = [[UIImageView alloc] init];
    _cloudLeftAnimView  = [[UIImageView alloc] init];
    _castleAnimView     = [[UIImageView alloc] init];
    _cloudUpAnimView    = [[UIImageView alloc] init];
    _cloudDownAnimView  = [[UIImageView alloc] init];
    _cloudFrontAnimView = [[UIImageView alloc] init];

    [self addSubview:_moonAnimView];
    [self addSubview:_cloudRightAnimView]; 
    [self addSubview:_cloudLeftAnimView]; 
    [self addSubview:_castleAnimView];
    [self addSubview:_cloudUpAnimView];
    [self addSubview:_cloudDownAnimView];
    [self addSubview:_cloudFrontAnimView];
    
    [self addSubview:_castleboomAnimView];
    
}

#pragma mark - 对外接口
- (void)setModel:(MZGiftModel *)model {

    //烟雾
    _castleboomAnimView.frame = CGRectMake(0,SCREEN_HEIGHT - KblueboomAnimViewHight - KblueboomAnimViewHightFooterSpace,SCREEN_WIDTH,KblueboomAnimViewHight);
    
    //月亮和竖右动画
    _moonAnimView.frame = CGRectMake(SCREEN_WIDTH - KMoonAnimViewWidth,-KMoonAnimViewWidthHigth,KMoonAnimViewWidth,KMoonAnimViewWidthHigth);
    _moonAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_moon_14th"];
    _cloudRightAnimView.frame = CGRectMake(SCREEN_WIDTH,KCloudRightAnimViewHightTopSpace,KCloudRightAnimViewWidth,KCloudRightAnimViewHight);
    _cloudRightAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_cloud_right_14th"];
    
    //树的左边动画
    _cloudLeftAnimView.frame = CGRectMake(- KCloudLeftAnimViewWidth,KCloudLeftAnimViewHightTopSpace,KCloudLeftAnimViewWidth,KCloudLeftAnimViewHight);
    _cloudLeftAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_cloud_left_14th"];
    
    
    //城堡动画
    _castleAnimView.frame = CGRectMake(SCREEN_WIDTH - KCastleAnimViewWidth,SCREEN_HEIGHT,KCastleAnimViewWidth,KCastleAnimViewHight);
    _castleAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_castle_14th"];
    
    //云上边动画
    _cloudUpAnimView.frame = CGRectMake(0,SCREEN_HEIGHT,KCloudUpAnimViewWidth,KCloudUpAnimViewHight);
    _cloudUpAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_cloud_up_14th"];
    
    //云 -下动画
    _cloudDownAnimView.frame = CGRectMake(0,SCREEN_HEIGHT,KCloudDownAnimViewWidth,KCloudDownAnimViewHight);
    _cloudDownAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_cloud_down_14th"];
    

    //云 -前 动画
    _cloudFrontAnimView.frame = CGRectMake( (SCREEN_WIDTH - KCloudFrontAnimViewWidth)/2,SCREEN_HEIGHT,KCloudFrontAnimViewWidth,KCloudFrontAnimViewHight);
    _cloudFrontAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_cloud_front_14th"];
    
    // 礼物数量
    self.skLabel.frame = CGRectMake(SCREEN_WIDTH - KLiveShakeLabelWidth - 8 ,160, KLiveShakeLabelWidth, KLiveShakeLabelHight);
  
    // 用户信息动画
    [self setupUserInfoAnimView:model];
   
}

- (void)animateWithCompleteBlock:(completeBlock)completed{
  
  //烟雾效果
  [self startboomAnimView];

  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
      _moonAnimView.frame = CGRectMake(_moonAnimView.frame.origin.x,KMoonAnimViewWidthHigthTopSpace,KMoonAnimViewWidth,KMoonAnimViewWidthHigth);
      _cloudRightAnimView.frame = CGRectMake(SCREEN_WIDTH - KCloudRightAnimViewWidth,KCloudRightAnimViewHightTopSpace,KCloudRightAnimViewWidth,KCloudRightAnimViewHight);
      _cloudLeftAnimView.frame = CGRectMake(0,KCloudLeftAnimViewHightTopSpace,KCloudLeftAnimViewWidth,KCloudLeftAnimViewHight);
      _castleAnimView.frame = CGRectMake(_castleAnimView.frame.origin.x,SCREEN_HEIGHT- KCastleAnimViewHightToFooterpSpace - KCastleAnimViewHight,KCastleAnimViewWidth,KCastleAnimViewHight);
      _cloudUpAnimView.frame = CGRectMake(0,SCREEN_HEIGHT - KCloudUpAnimViewHight - KCloudUpAnimViewHightToFooterpSpace,KCloudUpAnimViewWidth,KCloudUpAnimViewHight);
      _cloudDownAnimView.frame = CGRectMake(0,SCREEN_HEIGHT - KCloudDownAnimViewHight - KCloudDownAnimViewHightToFooterpSpace,KCloudDownAnimViewWidth,KCloudDownAnimViewHight);
      _cloudFrontAnimView.frame = CGRectMake( _cloudFrontAnimView.frame.origin.x,SCREEN_HEIGHT - KCloudFrontAnimViewHight - KCloudFrontAnimViewHightToFooterpSpace ,KCloudFrontAnimViewWidth,KCloudFrontAnimViewHight);
      
    
    } completion:^(BOOL finished) {
    
    
      [UIView upDownAnimation:_castleAnimView withAnimUpToDownHight:KAnimUpToDownHight withDuration:1 withRepeatCount:HUGE_VALF];
      [UIView upDownAnimation:_cloudUpAnimView withAnimUpToDownHight:KAnimUpToDownHight];
      [UIView downUpAnimation:_cloudDownAnimView withAnimUpToDownHight:KAnimUpToDownHight*3/2];
      [UIView upDownAnimation:_cloudFrontAnimView withAnimUpToDownHight:KAnimUpToDownHight withDuration:2 withRepeatCount:HUGE_VALF];
   
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          //用户打赏动画
          [self showUserInfoAinm]; 
        });  
          
      }];
  });
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self twinkleStarAnim:20];
  });
  
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self shakeNumberLabel];
  });
  

  self.completeBlock = completed;

}

/**
 烟雾动画
 */
-(void)startboomAnimView{
  NSArray *magesArray = [NSArray arrayWithObjects:
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_1"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_2"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_3"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_4"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_5"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_6"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_7"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_8"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_9"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_10"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_11"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_Pinkboom_12"],nil];
  _castleboomAnimView.animationImages = magesArray;//将序列帧数组赋给UIImageView的animationImages属性
  _castleboomAnimView.animationDuration = 0.6;//设置动画时间
  _castleboomAnimView.animationRepeatCount = 1;//设置动画次数 0 表示无限
  [_castleboomAnimView startAnimating];//开始播放动画    
  
  //延时结束刷新
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [_castleboomAnimView stopAnimating];
    _castleboomAnimView.alpha = 0;
    [_castleboomAnimView removeFromSuperview];
  });


}

/**
 随机显示 多少的 闪星星

 @param num 星星的个数
 */
-(void)twinkleStarAnim:(float )num{
    
   for (int i= 0; i <  num; i++) {
    
     UIImageView *starAnimView  =  [[UIImageView alloc] init];
     starAnimView.image  = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_star_castle"];
     starAnimView.frame   = [self randomAinmFrame];
     
     NSInteger oddNum =  i % 2;
     
    CAKeyframeAnimation *opacityAnimation;
    opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = (oddNum == 0)? @[@(0.6), @(1), @(0.6)]: @[@(1), @(0.6), @(1)];
    opacityAnimation.duration = 0.1;
    opacityAnimation.fillMode = kCAFillModeBoth;
    opacityAnimation.calculationMode = kCAAnimationCubic;
    opacityAnimation.repeatCount = HUGE_VALF;
    [starAnimView.layer addAnimation:opacityAnimation forKey:@"opacityAnimation"];

     [self addSubview:starAnimView];
   } 
}
/**
* 随机出现星星的位置
*/
-(CGRect )randomAinmFrame{
  
  int minWidth = 10;
  int maxWidth = 15;
  
  int leftMin = minWidth+1;
  int leftMax = (SCREEN_WIDTH - maxWidth - leftMin);
  
  int topMin  = 150;
  int topMax  = SCREEN_HEIGHT - 150;
  
  int x =  [self getRandomNumber:leftMin to:leftMax];
  
  int y =  [self getRandomNumber:topMin to:topMax];
  
  int w =  [self getRandomNumber:minWidth to:maxWidth];
  
  CGRect frame = CGRectMake(x,y,w,w);
  return frame;

}

@end
