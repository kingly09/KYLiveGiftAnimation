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

@interface MZMarkAnimView ()
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,copy) void(^completeBlock)(BOOL finished,NSInteger finishCount); // 新增了回调参数 finishCount， 用来记录动画结束时累加数量，将来在3秒内，还能继续累加
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

    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.backgroundColor = [UIColor blackColor];
    _bgImageView.alpha = 0.3;
    _headImageView = [[UIImageView alloc] init];
    _giftImageView = [[UIImageView alloc] init];
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
    
    [self addSubview:_bgImageView];
    [self addSubview:_headImageView];
    [self addSubview:_giftImageView];
    [self addSubview:_nameLabel];
    [self addSubview:_giftLabel];
    [self addSubview:_skLabel];

}

#pragma mark 布局 UI
- (void)layoutSubviews {
    
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(KLivePresentViewWidthSpace, 0, self.frame.size.height, self.frame.size.height);
    _headImageView.layer.cornerRadius = _headImageView.frame.size.height / 2;
    _headImageView.layer.masksToBounds = YES;
    
    _giftImageView.frame = CGRectMake(self.frame.size.width - KGiftImageViewWidth + KLivePresentViewWidthSpace, self.frame.size.height - KGiftImageViewWidth, KGiftImageViewWidth, KGiftImageViewWidth);
    
    _nameLabel.frame = CGRectMake(_headImageView.frame.size.width + KLivePresentViewWidthSpace*2, 0, KLivePresentViewWidth - KGiftImageViewWidth - self.frame.size.height, self.frame.size.height/2);
    _giftLabel.frame = CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_headImageView.frame) - self.frame.size.height/2-2, _nameLabel.frame.size.width, self.frame.size.height/2);
    
    _bgImageView.frame = self.bounds;
    _bgImageView.frame = CGRectMake(KLivePresentViewWidthSpace, 0, self.frame.size.width - KLivePresentViewWidthSpace, self.frame.size.height);
    
    _bgImageView.layer.cornerRadius = self.frame.size.height / 2;
    _bgImageView.layer.masksToBounds = YES;
    
    _skLabel.frame = CGRectMake(CGRectGetMaxX(_giftImageView.frame),self.frame.size.height-KLiveShakeLabelHight, KLiveShakeLabelWidth, KLiveShakeLabelHight);
    
}

#pragma mark - 对外接口

- (void)setModel:(MZGiftModel *)model {

  if (_model != model) {
        _model = nil;
        _model = model;

#warning  修改
    _headImageView.image = model.headImage;
    _giftImageView.image = model.giftImage;
    _nameLabel.text = model.userName;
    _giftLabel.text = [NSString stringWithFormat:@"送出【%@】",model.giftName];
    _giftCount = model.giftCount;
    
    }
}


- (void)animateWithCompleteBlock:(completeBlock)completed{

   [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
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
    [self.skLabel startAnimWithDuration:0.3];


}

- (void)hideCurretView{
    
     [UIView animateWithDuration:0.30 delay:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y - 20, self.frame.size.width, self.frame.size.height);
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
