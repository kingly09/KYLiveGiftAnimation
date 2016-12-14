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


#define KUserInfoAnimViewWidth  277
#define KUserInfoAnimViewHight  62.5
#define KUserInfoAnimViewHightFooterSpace  333

#define KFeather1MaskAnimViewWidth 305
#define KFeather1MaskAnimViewHigth 101.5
#define KFeather1MaskAnimViewHigthTopSpace  158.5
#define KFeather1MaskAnimViewRightSpace  13.5

#define KFeather2MaskAnimViewWidth 311.5
#define KFeather2MaskAnimViewHigth 106.5
#define KFeather2MaskAnimViewHigthTopSpace  162.5
#define KFeather2MaskAnimViewLeftSpace  50

@interface MZMarkAnimView ()
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,copy) void(^completeBlock)(BOOL finished,NSInteger finishCount); // 新增了回调参数 finishCount， 用来记录动画结束时累加数量，将来在3秒内，还能继续累加

@property (nonatomic,strong) UIImageView *markImageView;      //面具动画

@property (nonatomic,strong) UIImageView *markboomAnimView;   //烟雾动画

@property (nonatomic,strong) UIImageView *userInfoAnimView;   //用户信息动画

@property (nonatomic,strong) UIImageView *feather1MaskAnimView; //羽毛01

@property (nonatomic,strong) UIImageView *feather2MaskAnimView; //羽毛02

@end

@implementation MZMarkAnimView

- (instancetype)init {
    if (self = [super init]) {
        _originFrame = self.frame;
        [self setupCustomView];
    }
    return self;
}

-(void)setupCustomView{


    //面具
    _markImageView = [[UIImageView alloc] init];
   
    _markboomAnimView  =  [[UIImageView alloc] init];

    _userInfoAnimView  = [[UIImageView alloc] init];
    
    _feather1MaskAnimView = [[UIImageView alloc] init];

    _feather2MaskAnimView = [[UIImageView alloc] init];

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
    
    [self addSubview:_markImageView];
    [self addSubview:_markboomAnimView];
    [self addSubview:_feather1MaskAnimView];
    [self addSubview:_feather2MaskAnimView];
    
    [self addSubview:_userInfoAnimView];
    [_userInfoAnimView addSubview:_nameLabel];
    [_userInfoAnimView addSubview:_giftLabel];
    [self addSubview:_skLabel];
    
    


}

#pragma mark - 对外接口
- (void)setModel:(MZGiftModel *)model {

  if (_model != model) {
    _model = nil;
    _model = model;
    
    //烟雾
    _markboomAnimView.frame = CGRectMake(0,SCREEN_HEIGHT - KblueboomAnimViewHight - KblueboomAnimViewHightFooterSpace,SCREEN_WIDTH,KblueboomAnimViewHight);
    
            
    _markImageView.frame = CGRectMake((SCREEN_WIDTH - KMarkImageViewWidth)/2,0, KMarkImageViewWidth, KMarkImageViewHight);
    _markImageView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_mask_bigger_14th"];
    _markImageView.hidden = YES;
    
    _feather1MaskAnimView.frame = CGRectMake(SCREEN_WIDTH - KFeather1MaskAnimViewWidth - KFeather1MaskAnimViewRightSpace,KFeather1MaskAnimViewHigthTopSpace, KFeather1MaskAnimViewWidth, KFeather1MaskAnimViewHigth);
    _feather1MaskAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_feather1_mask_14th"];
    _feather1MaskAnimView.hidden = YES;
    
    _feather2MaskAnimView.frame = CGRectMake(SCREEN_WIDTH - KFeather2MaskAnimViewWidth - KFeather2MaskAnimViewLeftSpace,KFeather2MaskAnimViewHigthTopSpace, KFeather2MaskAnimViewWidth, KFeather2MaskAnimViewHigth);
    _feather2MaskAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_feather2_mask_14th"];
    _feather2MaskAnimView.hidden = YES;
    
    //用户打赏信息动画
    _userInfoAnimView.frame = CGRectMake((SCREEN_WIDTH - KUserInfoAnimViewWidth)/2,SCREEN_HEIGHT - KUserInfoAnimViewHightFooterSpace - KUserInfoAnimViewHight, KUserInfoAnimViewWidth, KUserInfoAnimViewHight);
    _userInfoAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_background_mask_14th"];
    _userInfoAnimView.hidden = YES;
   
    _skLabel.frame = CGRectMake(SCREEN_WIDTH - KLiveShakeLabelWidth - 15 ,199, KLiveShakeLabelWidth, KLiveShakeLabelHight);
  
    _nameLabel.frame = CGRectMake(KAnimNameLabelLeftSPace,KAnimMameLabelTopSPace, KUserInfoAnimViewWidth - KAnimNameLabelLeftSPace*2, (KUserInfoAnimViewHight - KAnimNameLabelFooterSPace - KAnimMameLabelTopSPace)/2);
    _giftLabel.frame = CGRectMake(_nameLabel.frame.origin.x,KAnimMameLabelTopSPace+_nameLabel.frame.size.height, _nameLabel.frame.size.width,_nameLabel.frame.size.height);
    
    NSString *nameLabelStr = [NSString stringWithFormat:@"感谢%@",model.userName];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:nameLabelStr];
    NSRange rangeStr = [nameLabelStr rangeOfString:[NSString stringWithFormat:@"%@",model.userName]];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x00ff00] range:rangeStr];
    _nameLabel.attributedText = attstr;
   
    NSString *giftLabelStr = [NSString stringWithFormat:@"送出的【%@】",model.giftName.length>0?model.giftName:@"【贵州面具】"];
    NSMutableAttributedString *giftattstr = [[NSMutableAttributedString alloc]initWithString:giftLabelStr];
    NSRange giftrangeStr = [giftLabelStr rangeOfString:[NSString stringWithFormat:@"【%@】",model.giftName]];
    [giftattstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x00eaff] range:giftrangeStr];
    _giftLabel.attributedText = giftattstr;
    _giftCount = model.giftCount;

  }
}

- (void)animateWithCompleteBlock:(completeBlock)completed{
  
  //烟雾效果
  [self startPurpleboomAnimView];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
      [self showMarkImageViewAinm];
      [self showFeatherAinm];
      
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
