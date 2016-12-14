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


#define KUserInfoAnimViewWidth  277
#define KUserInfoAnimViewHight  62.5
#define KUserInfoAnimViewHightFooterSpace  333

#define KMoonAnimViewWidth 142.5
#define KMoonAnimViewWidthHigth 157.0
#define KMoonAnimViewWidthHigthTopSpace 147.0

#define KCloudRightAnimViewWidth 58
#define KCloudRightAnimViewHight 78.5
#define KCloudRightAnimViewHightTopSpace 225.5

@interface MZCastleAnimView ()
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,copy) void(^completeBlock)(BOOL finished,NSInteger finishCount); // 新增了回调参数 finishCount， 用来记录动画结束时累加数量，将来在3秒内，还能继续累加

@property (nonatomic,strong) UIImageView *castleboomAnimView;   //烟雾动画
@property (nonatomic,strong) UIImageView *userInfoAnimView;   //用户信息动画

@property (nonatomic,strong) UIImageView *moonAnimView;       //月亮动画
@property (nonatomic,strong) UIImageView *cloudRightAnimView; //树右动画


@end

@implementation MZCastleAnimView

- (instancetype)init {
    if (self = [super init]) {
        _originFrame = self.frame;
        [self setupCustomView];
    }
    return self;
}

-(void)setupCustomView{


  
    _castleboomAnimView  =  [[UIImageView alloc] init];
    _userInfoAnimView  = [[UIImageView alloc] init];
    
    _moonAnimView = [[UIImageView alloc] init];
    _cloudRightAnimView = [[UIImageView alloc] init];

    _nameLabel = [[UILabel alloc] init];
    _giftLabel = [[UILabel alloc] init];
    
    _nameLabel.textColor  = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    
    _giftLabel.textColor  = [UIColor whiteColor];
    _giftLabel.font = [UIFont systemFontOfSize:15];
    
    // 初始化动画label
    _skLabel =  [[MZShakeLabel alloc] init];
    _skLabel.font = [UIFont systemFontOfSize:25];
    _skLabel.borderColor = [UIColor whiteColor];
    _skLabel.textColor = [UIColor colorWithHex:0xff3c6f];
    _skLabel.textAlignment = NSTextAlignmentLeft;
    _animCount = 0;
    

    [self addSubview:_moonAnimView];
    [self addSubview:_cloudRightAnimView];  
    
    [self addSubview:_userInfoAnimView];

    [_userInfoAnimView addSubview:_nameLabel];
    [_userInfoAnimView addSubview:_giftLabel];
    [self addSubview:_skLabel];
    [self addSubview:_castleboomAnimView];
    
    


}

#pragma mark - 对外接口
- (void)setModel:(MZGiftModel *)model {

  if (_model != model) {
    _model = nil;
    _model = model;
    
    //烟雾
    _castleboomAnimView.frame = CGRectMake(0,SCREEN_HEIGHT - KblueboomAnimViewHight - KblueboomAnimViewHightFooterSpace,SCREEN_WIDTH,KblueboomAnimViewHight);
    
    //月亮和竖右动画
    _moonAnimView.frame = CGRectMake(SCREEN_WIDTH - KMoonAnimViewWidth,-KMoonAnimViewWidthHigth,KMoonAnimViewWidth,KMoonAnimViewWidthHigth);
    _moonAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_moon_14th"];
    _cloudRightAnimView.frame = CGRectMake(SCREEN_WIDTH,KCloudRightAnimViewHightTopSpace,KCloudRightAnimViewWidth,KCloudRightAnimViewHight);
    _cloudRightAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_cloud_right_14th"];
     
    //用户打赏信息动画
    _userInfoAnimView.frame = CGRectMake((SCREEN_WIDTH - KUserInfoAnimViewWidth)/2,SCREEN_HEIGHT - KUserInfoAnimViewHightFooterSpace - KUserInfoAnimViewHight, KUserInfoAnimViewWidth, KUserInfoAnimViewHight);
    _userInfoAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_background_queen_14th"];
    _userInfoAnimView.hidden = YES;
   
    _skLabel.frame = CGRectMake(SCREEN_WIDTH - KLiveShakeLabelWidth - 8 ,160, KLiveShakeLabelWidth, KLiveShakeLabelHight);
  
    _nameLabel.frame = CGRectMake(KAnimNameLabelLeftSPace,KAnimMameLabelTopSPace, KUserInfoAnimViewWidth - KAnimNameLabelLeftSPace*2, (KUserInfoAnimViewHight - KAnimNameLabelFooterSPace - KAnimMameLabelTopSPace)/2);
    _giftLabel.frame = CGRectMake(_nameLabel.frame.origin.x,KAnimMameLabelTopSPace+_nameLabel.frame.size.height, _nameLabel.frame.size.width,_nameLabel.frame.size.height);
    
    NSString *nameLabelStr = [NSString stringWithFormat:@"感谢%@",model.userName];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:nameLabelStr];
    NSRange rangeStr = [nameLabelStr rangeOfString:[NSString stringWithFormat:@"%@",model.userName]];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x00ff00] range:rangeStr];
    _nameLabel.attributedText = attstr;
   
    NSString *giftLabelStr = [NSString stringWithFormat:@"送出的【%@】",model.giftName.length>0?model.giftName:@"【女皇的城堡】"];
    NSMutableAttributedString *giftattstr = [[NSMutableAttributedString alloc]initWithString:giftLabelStr];
    NSRange giftrangeStr = [giftLabelStr rangeOfString:[NSString stringWithFormat:@"【%@】",model.giftName]];
    [giftattstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x00eaff] range:giftrangeStr];
    _giftLabel.attributedText = giftattstr;
    _giftCount = model.giftCount;

  }
}

- (void)animateWithCompleteBlock:(completeBlock)completed{
  
  //烟雾效果
  [self startboomAnimView];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
      _moonAnimView.frame = CGRectMake(_moonAnimView.frame.origin.x,KMoonAnimViewWidthHigthTopSpace,KMoonAnimViewWidth,KMoonAnimViewWidthHigth);
      _cloudRightAnimView.frame = CGRectMake(SCREEN_WIDTH - KCloudRightAnimViewWidth,KCloudRightAnimViewHightTopSpace,KCloudRightAnimViewWidth,KCloudRightAnimViewHight);
    
    } completion:^(BOOL finished) {
    
     
      //用户打赏动画
      [self showUserInfoAinm];   
    }];
  });
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self shakeNumberLabel];
  });
  

  self.completeBlock = completed;

}



// 显示用户打赏信息 
-(void)showUserInfoAinm{
  _userInfoAnimView.hidden = NO;
  self.userInfoAnimView.alpha = 0;
  [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations:^{
        self.userInfoAnimView.alpha = 1;
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/2.0 animations:^{
            
            self.userInfoAnimView.transform = CGAffineTransformMakeScale(3, 3);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations:^{
            
            self.userInfoAnimView.transform = CGAffineTransformMakeScale(1, 1);
        }];
        
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.userInfoAnimView.alpha = 1;
                self.userInfoAnimView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:nil];
         
        }];
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

// 打赏的数量
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

// 重置
- (void)resetframe {
    self.frame = _originFrame;
    self.alpha = 1;
    self.animCount = 0;
    self.giftCount = 0;
    self.skLabel.text = @"";
}

@end
