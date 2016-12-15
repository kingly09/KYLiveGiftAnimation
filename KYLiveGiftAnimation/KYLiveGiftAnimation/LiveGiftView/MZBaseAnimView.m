//
//  MZBaseAnimView.m
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

#import "MZBaseAnimView.h"
#import "MZLiveGiftAnimationHeader.h"


@interface MZBaseAnimView ()

@end

@implementation MZBaseAnimView

- (instancetype)init {
  if (self = [super init]) {
    //初始化公共
    [self setupInit];
    //自定义初始化视图
    [self setupCustomView];
    //添加公共视图
    [self pubicView];
  }
  return self;
}

-(void)setupInit{

   _originFrame = self.frame;
    
    //用户信息
    _userInfoAnimView  = [[UIImageView alloc] init];
    
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

}

/**
 * 公共视图初始化
 **/
-(void)pubicView{

    [self addSubview:_userInfoAnimView];
    [_userInfoAnimView addSubview:_nameLabel];
    [_userInfoAnimView addSubview:_giftLabel];
    [self addSubview:_skLabel];

}

//子类重写
-(void)setupCustomView{
  ;
}

/// 动画完成后的回调
- (void)animateWithCompleteBlock:(completeBlock)completed{
   //子类重写
   ;
}
/// 如果自定义，子类重写
- (void)shakeNumberLabel{

  self.animCount ++; 
   
   if (self.giftCount > 0) {
      self.animCount =  self.giftCount;
   }
   
   if (self.animCount > KLiveShakeLabelMaxNum ) {
      
      self.animCount = KLiveShakeLabelMaxNum;
   }

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideCurretView) object:nil];//可以取消成功。
    [self performSelector:@selector(hideCurretView) withObject:nil afterDelay:2];
    
    self.skLabel.text = [NSString stringWithFormat:@"x %ld",self.animCount];
    [self.skLabel startAnimWithDuration:0.5];
}

/// 如果自定义，子类重写
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

/**
*  取一个随机整数，范围在[from,to），包括from，包括to
*/
-(int)getRandomNumber:(int)from to:(int)to

{
    return (int)(from + (arc4random() % (to - from + 1)));

}

#pragma mark - 用户打赏动画
/**
 显示用户信息动画
 */
-(void)setupUserInfoAnimView:(MZGiftModel *)model{
  
   //用户打赏信息动画
   NSString *userInfoBackground = @"";
    if (model.giftType == GIFT_TYPE_MASK) {
        userInfoBackground = @"ic_background_mask_14th";
    }else if (model.giftType == GIFT_TYPE_CASTLE) {
        userInfoBackground = @"ic_background_queen_14th";
    }else if (model.giftType == GIFT_TYPE_OCEAN){
        userInfoBackground = @"ic_background_seastar_14th";
    }
    self.userInfoAnimView.image = [[MZAnimationImageCache shareInstance] getImageWithName:userInfoBackground];
    self.userInfoAnimView.hidden = YES;
   
    self.userInfoAnimView.frame = CGRectMake((SCREEN_WIDTH - KUserInfoAnimViewWidth)/2,SCREEN_HEIGHT - KUserInfoAnimViewHightFooterSpace - KUserInfoAnimViewHight, KUserInfoAnimViewWidth, KUserInfoAnimViewHight);
    self.nameLabel.frame = CGRectMake(KAnimNameLabelLeftSPace,KAnimMameLabelTopSPace, KUserInfoAnimViewWidth - KAnimNameLabelLeftSPace*2, (KUserInfoAnimViewHight - KAnimNameLabelFooterSPace - KAnimMameLabelTopSPace)/2);
    self.giftLabel.frame = CGRectMake(self.nameLabel.frame.origin.x,KAnimMameLabelTopSPace+self.nameLabel.frame.size.height, self.nameLabel.frame.size.width,self.nameLabel.frame.size.height);
    
    NSString *nameLabelStr = [NSString stringWithFormat:@"感谢%@",model.user.userName];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:nameLabelStr];
    NSRange rangeStr = [nameLabelStr rangeOfString:[NSString stringWithFormat:@"%@",model.user.userName]];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x00ff00] range:rangeStr];
    self.nameLabel.attributedText = attstr;
   
    if (model.giftType == GIFT_TYPE_MASK) {
      model.giftName = model.giftName.length>0?model.giftName:@"贵族面具";
    }else if (model.giftType == GIFT_TYPE_CASTLE) {
      model.giftName = model.giftName.length>0?model.giftName:@"女皇的城堡";
    }else if (model.giftType == GIFT_TYPE_OCEAN) {
      model.giftName = model.giftName.length>0?model.giftName:@"海洋之星";
    }
   
    NSString *giftLabelStr = [NSString stringWithFormat:@"送出的【%@】",model.giftName];
    NSMutableAttributedString *giftattstr = [[NSMutableAttributedString alloc]initWithString:giftLabelStr];
    NSRange giftrangeStr = [giftLabelStr rangeOfString:[NSString stringWithFormat:@"【%@】",model.giftName]];
    [giftattstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x00eaff] range:giftrangeStr];
    self.giftLabel.attributedText = giftattstr;
    self.giftCount = model.giftCount;

}

// 显示用户打赏信息 
-(void)showUserInfoAinm{

  self.userInfoAnimView.hidden = NO;
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


@end
