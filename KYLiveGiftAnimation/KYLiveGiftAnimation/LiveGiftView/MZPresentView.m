//
//  MZPresentView.m
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

#import "MZPresentView.h"
#import "MZLiveGiftAnimationHeader.h"

@interface MZPresentView ()
@property (nonatomic,strong) UIImageView *bgImageView;
@end

@implementation MZPresentView


- (instancetype)init {
    if (self = [super init]) {
    
    }
    return self;
}

-(void)setupCustomView{
     
 
     
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.backgroundColor = [UIColor blackColor];
    _bgImageView.alpha = 0.3;
    _headImageView = [[UIImageView alloc] init];
    _giftImageView = [[UIImageView alloc] init];
    
    self.nameLabel = [[UILabel alloc] init];
    self.giftLabel = [[UILabel alloc] init];
    
    self.nameLabel.textColor  = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    
    self.giftLabel.textColor  = [UIColor colorWithHex:0x00eaff];
    self.giftLabel.font = [UIFont systemFontOfSize:12];
    
    

    [self addSubview:_bgImageView];
    [self addSubview:_headImageView];
    [self addSubview:_giftImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.giftLabel];
    
    

}

-(void)pubicView{
 ;
}

#pragma mark 布局 UI
- (void)layoutSubviews {
    
    [super layoutSubviews];
  
    _headImageView.frame = CGRectMake(KLivePresentViewWidthSpace, 0, self.frame.size.height, self.frame.size.height);
  
    _giftImageView.frame = CGRectMake(self.frame.size.width - KGiftImageViewWidth + KLivePresentViewWidthSpace, self.frame.size.height - KGiftImageViewWidth, KGiftImageViewWidth, KGiftImageViewWidth);
    
    self.nameLabel.frame = CGRectMake(_headImageView.frame.size.width + KLivePresentViewWidthSpace*2, 0, KLivePresentViewWidth - KGiftImageViewWidth - self.frame.size.height, self.frame.size.height/2);
    self.giftLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, CGRectGetMaxY(self.headImageView.frame) - self.frame.size.height/2-2, self.nameLabel.frame.size.width, self.frame.size.height/2);
    
    _bgImageView.frame = self.bounds;
    _bgImageView.frame = CGRectMake(KLivePresentViewWidthSpace, 0, self.frame.size.width - KLivePresentViewWidthSpace, self.frame.size.height);
    
    _bgImageView.layer.cornerRadius = self.frame.size.height / 2;
    _bgImageView.layer.masksToBounds = YES;
    
    self.skLabel.frame = CGRectMake(CGRectGetMaxX(_giftImageView.frame),self.frame.size.height-KLiveShakeLabelHight, KLiveShakeLabelWidth, KLiveShakeLabelHight);
    
}

#pragma mark - 对外接口

- (void)setModel:(MZGiftModel *)model {
     
    self.nameLabel.text = model.user.userName;
    self.giftLabel.text = [NSString stringWithFormat:@"送出【%@】",model.giftName];
    self.giftCount = model.giftCount;
    
}


- (void)animateWithCompleteBlock:(completeBlock)completed{

   [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self shakeNumberLabel];
    }];
    self.completeBlock = completed;


}

/// 自定义隐藏动画 - 子类重写
- (void)hideCurretView{
    
     [UIView animateWithDuration:0.30 delay:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y - 20, self.frame.size.width, self.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.completeBlock) {
            self.completeBlock(finished,self.animCount);
        }
        [self resetframe];
        self.finished = finished;
        [self removeFromSuperview];
    }];

}

@end
