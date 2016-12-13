//
//  MZRightAnimView.m
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

#import "MZRightAnimView.h"

#import "MZLiveGiftAnimationHeader.h"

@interface MZRightAnimView ()
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,copy) void(^completeBlock)(BOOL finished,NSInteger finishCount); // 新增了回调参数 finishCount， 用来记录动画结束时累加数量，将来在3秒内，还能继续累加

@property (nonatomic,strong) UIImageView *loveAnimateView;
@property (nonatomic,strong) UIImageView *hotGasAnimateView;  //热气
@property (nonatomic,strong) UIImageView *coffeeCupImageView; //杯子

@end

@implementation MZRightAnimView

- (instancetype)init {
    if (self = [super init]) {
        _originFrame = self.frame;
        [self setupCustomView];
    }
    return self;
}

-(void)setupCustomView{

    _bgImageView = [[UIImageView alloc] init];
  
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
    
    //爱心动画
    _loveAnimateView = [[UIImageView alloc] init];
    
    //热气动画
    _hotGasAnimateView  = [[UIImageView alloc] init];
    _coffeeCupImageView = [[UIImageView alloc] init];
    
    [self addSubview:_bgImageView];
    [self addSubview:_nameLabel];
    [self addSubview:_giftLabel];
    [self addSubview:_skLabel];
    [self addSubview:_loveAnimateView];
    
    
    [self addSubview:_coffeeCupImageView];
    [_coffeeCupImageView addSubview:_hotGasAnimateView];
    
}

#pragma mark 布局 UI
- (void)layoutSubviews {
    
    [super layoutSubviews];
  
    
    _nameLabel.frame = CGRectMake(KLiveRightAnimViewLabelSpace, KLiveRightAnimViewLabelVarSpace, KLiveRightAnimViewLabelWidth, KLiveRightAnimViewLabelHight);
    _giftLabel.frame = CGRectMake(_nameLabel.frame.origin.x, KLiveRightAnimViewLabelHight+KLiveRightAnimViewLabelVarSpace, KLiveRightAnimViewLabelWidth, KLiveRightAnimViewLabelHight);
    
    _bgImageView.frame = self.bounds;
    _bgImageView.frame = CGRectMake(0, 0, self.frame.size.width - KLiveRightAnimViewWidthSpace, self.frame.size.height);
    _bgImageView.image = [[MZAnimationImageCache shareInstance] getImageWithName:@"bg_backgroundcolor_14th"];
  
    _loveAnimateView.frame = CGRectMake(0,-KLiveRightAnimViewLoveHight+KLiveRightAnimViewLabelVarSpace*2, KLiveRightAnimViewLoveWidth,KLiveRightAnimViewLoveHight);
    _skLabel.frame = CGRectMake(self.frame.size.width - KLiveShakeLabelWidth,-KLiveRightAnimViewShakeNumberLabelVarSpace-KLiveShakeLabelHight, KLiveShakeLabelWidth, KLiveShakeLabelHight);
    
    _coffeeCupImageView.frame = CGRectMake(0,-KLiveRightAnimViewLoveHight+KLiveRightAnimViewLabelVarSpace*2,KLiveRightAnimViewLoveWidth,KLiveRightAnimViewLoveHight);
    _hotGasAnimateView.frame  = CGRectMake(KLiveCoffeeCupImageViewWidthSpace,KLiveCoffeeCupImageViewHightSpace,KLiveCoffeeCupImageViewWidth,KLiveCoffeeCupImageViewHight);
}

#pragma mark - 对外接口

- (void)setModel:(MZGiftModel *)model {

  if (_model != model) {
    _model = nil;
    _model = model;
    

    NSString *nameLabelStr = [NSString stringWithFormat:@"感谢%@",model.userName];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:nameLabelStr];
    NSRange rangeStr = [nameLabelStr rangeOfString:[NSString stringWithFormat:@"%@",model.userName]];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x00ff00] range:rangeStr];
    _nameLabel.attributedText = attstr;

    NSString *giftLabelStr = [NSString stringWithFormat:@"送出的【%@】",model.giftName];
    NSMutableAttributedString *giftattstr = [[NSMutableAttributedString alloc]initWithString:giftLabelStr];
    NSRange giftrangeStr = [giftLabelStr rangeOfString:[NSString stringWithFormat:@"【%@】",model.giftName]];
    [giftattstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x00eaff] range:giftrangeStr];
    _giftLabel.attributedText = giftattstr;
    _giftCount = model.giftCount;
    
  }
}


- (void)animateWithCompleteBlock:(completeBlock)completed{

   [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(KLiveRightAnimViewWidthOriginX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
    
       if (_model.gifType == GIFT_TYPE_COOFFEE) {
          [self showOffeeAnim];
       }else if (_model.gifType == GIFT_TYPE_GUARD){
          [self showLoveAnim];
       }
       
    }];
    self.completeBlock = completed;

}

//爱心动画
-(void)showLoveAnim{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self startLoveAnimating];
    } completion:^(BOOL finished) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self shakeNumberLabel];
      });
    }];
}

//咖啡动画
-(void)showOffeeAnim{

    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
          [self startOffeeAnimating];
    } completion:^(BOOL finished) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self shakeNumberLabel];
      });
    }];

}

- (void)shakeNumberLabel{
  
   _animCount ++; 
   
   if (_giftCount > 0) {
      _animCount =  _giftCount;
   }
   
   if (_animCount > KLiveShakeLabelMaxNum ) {
      
      _animCount = KLiveShakeLabelMaxNum;
   }

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideRightAnimView) object:nil];//可以取消成功。
    [self performSelector:@selector(hideRightAnimView) withObject:nil afterDelay:3];
    
    self.skLabel.text = [NSString stringWithFormat:@"x %ld",_animCount];
    [self.skLabel startAnimWithDuration:0.5];


}

- (void)hideRightAnimView{
    
     [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(SCREEN_WIDTH, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
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


/**
 * @brief 开始动画
 */
- (void)startLoveAnimating
{
 
   [UIView downUpAnimation:self.loveAnimateView 
    withAnimUpToDownHight:KLiveRightAnimViewLabelVarSpace*2 
             withDuration:0.5 
          withRepeatCount:1];

  NSArray *magesArray = [NSArray arrayWithObjects:
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_heart_1_14th"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_heart_2_14th"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_heart_3_14th"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_heart_4_14th"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_heart_5_14th"],nil];
  _loveAnimateView.animationImages = magesArray;//将序列帧数组赋给UIImageView的animationImages属性
  _loveAnimateView.animationDuration = 0.5;//设置动画时间
  _loveAnimateView.animationRepeatCount = 0;//设置动画次数 0 表示无限
  [_loveAnimateView startAnimating];//开始播放动画    
  
  //延时结束刷新
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [_loveAnimateView stopAnimating];
  });
  
}

// 开始offee动画
- (void)startOffeeAnimating {
  [UIView downUpAnimation:self.coffeeCupImageView 
    withAnimUpToDownHight:KLiveRightAnimViewLabelVarSpace*2 
             withDuration:0.5 
          withRepeatCount:1];
  
  //热气动画
  NSArray *magesArray = [NSArray arrayWithObjects:
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_1"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_2"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_3"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_4"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_5"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_6"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_7"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_8"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_9"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_10"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_11"],
                         [[MZAnimationImageCache shareInstance] getImageWithName:@"ic_fogmov_14th_12"],nil];
  _coffeeCupImageView.animationImages = magesArray;//将序列帧数组赋给UIImageView的animationImages属性
  _coffeeCupImageView.animationDuration = 1.6;//设置动画时间
  _coffeeCupImageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
  [_coffeeCupImageView startAnimating];//开始播放动画    
  
  //延时结束刷新
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [_coffeeCupImageView stopAnimating];
  });
  
}

// 热气动画
-(void)hotGasAnimation{

  [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _hotGasAnimateView.center  = CGPointMake(_hotGasAnimateView.center.x-10,_hotGasAnimateView.center.y-10);
        _hotGasAnimateView.alpha = 0;
  } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _hotGasAnimateView.center  = CGPointMake(_hotGasAnimateView.center.x-10,_hotGasAnimateView.center.y-10);
            _hotGasAnimateView.alpha = 1;
        } completion:^(BOOL finished) {
             [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
              _hotGasAnimateView.center  = CGPointMake(_hotGasAnimateView.center.x-10,_hotGasAnimateView.center.y-10);
              _hotGasAnimateView.alpha = 0;

            } completion:^(BOOL finished) {
                
                 [self hotGasAnimation];
            }];
        }];
          
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
