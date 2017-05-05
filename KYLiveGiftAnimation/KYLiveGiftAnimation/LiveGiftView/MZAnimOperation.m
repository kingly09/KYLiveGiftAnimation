//
//  MZAnimOperation.m
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

#import "MZAnimOperation.h"

@interface MZAnimOperation ()
@property (nonatomic, getter = isFinished)  BOOL finished;
@property (nonatomic, getter = isExecuting) BOOL executing;
@property (nonatomic,copy) void(^finishedBlock)(BOOL result,NSInteger finishCount);
@end

@implementation MZAnimOperation

@synthesize finished = _finished;
@synthesize executing = _executing;

+ (instancetype)animOperationWithGiftModel:(MZGiftModel *)model finishedBlock:(void(^)(BOOL result,NSInteger finishCount))finishedBlock; {
    MZAnimOperation *op = [[MZAnimOperation alloc] init];
    
  if (model.giftType == GIFT_TYPE_DEFAULT) { //普通动画
      op.presentView = [[MZPresentView alloc] init];
   }else if (model.giftType == GIFT_TYPE_GUARD) { //爱心守护者
      op.rightAnimView = [[MZRightAnimView alloc] init];
   }else if (model.giftType == GIFT_TYPE_MASK) {  //贵族面具
      op.markAnimView  = [[MZMarkAnimView alloc] init];
   }else if (model.giftType == GIFT_TYPE_OCEAN) { //海洋之星
      op.oceanAnimView = [[MZOceanAnimView alloc]init];
   }else if (model.giftType == GIFT_TYPE_COOFFEE) { //咖啡印记
      op.rightAnimView = [[MZRightAnimView alloc] init];
   }else if (model.giftType == GIFT_TYPE_CASTLE) { //女皇的城堡
      op.castleAnimView = [[MZCastleAnimView alloc] init];
   }else if (model.giftType == GIFT_TYPE_BURSTS) { //连发动画
      op.presentView = [[MZPresentView alloc] init];
   }
    op.model = model;
    op.finishedBlock = finishedBlock;
    return op;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _executing = NO;
        _finished  = NO;
    }
    return self;
}

- (void)start {
    // 添加到队列时调用
    if ([self isCancelled]) {
        self.finished = YES;
        return;
    }
    self.executing = YES;
    
  if (_model.giftType == GIFT_TYPE_DEFAULT) { //普通动画
          [self addOperationWithPresentView];
   }else if (_model.giftType == GIFT_TYPE_GUARD) { //爱心守护者
          [self addOperationWithPightAnimView];
   }else if (_model.giftType == GIFT_TYPE_MASK) {  //贵族面具
          [self addOperationWithMarkAnimView];
   }else if (_model.giftType == GIFT_TYPE_OCEAN) {  //海洋之星
          [self addOperationWithOceanAnimView];
   }else if (_model.giftType == GIFT_TYPE_COOFFEE) { //咖啡印记
          [self addOperationWithPightAnimView];
   }else if (_model.giftType == GIFT_TYPE_CASTLE) {  //女皇的城堡
          [self addOperationWithCastleAnimView];
   }else if (_model.giftType == GIFT_TYPE_BURSTS) {  //连发动画
          [self addOperationWithPresentView];
   }
}

// 普通动画 和 连发动画 添加到队列
-(void) addOperationWithPresentView{

 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _presentView.model = _model;
        _presentView.originFrame = _presentView.frame;
        [self.listView addSubview:_presentView];
        
        [self.presentView animateWithCompleteBlock:^(BOOL finished,NSInteger finishCount) {
            self.finished = finished;
            self.finishedBlock(finished,finishCount);
        }];
  }];

}

// 右边动画添加到队列
-(void) addOperationWithPightAnimView{

     [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _rightAnimView.model = _model;
        _rightAnimView.originFrame = _rightAnimView.frame;
        [self.rightAnimlistView addSubview:_rightAnimView];
        
        [self.rightAnimView animateWithCompleteBlock:^(BOOL finished,NSInteger finishCount) {
            self.finished = finished;
            self.finishedBlock(finished,finishCount);
        }];
  }];
}

// 海洋之星动画添加到队列
-(void)addOperationWithOceanAnimView{

  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _oceanAnimView.model = _model;
        _oceanAnimView.originFrame = _oceanAnimView.frame;
        [self.oceanAnimlistView addSubview:_oceanAnimView];
        
        [self.oceanAnimView animateWithCompleteBlock:^(BOOL finished,NSInteger finishCount) {
            self.finished = finished;
            self.finishedBlock(finished,finishCount);
        }];
  }];

}

// 女皇的城堡动画添加到队列
-(void)addOperationWithCastleAnimView{

  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _castleAnimView.model = _model;
        _castleAnimView.originFrame = _castleAnimView.frame;
        [self.castleAnimlistView addSubview:_castleAnimView];
        
        [self.castleAnimView animateWithCompleteBlock:^(BOOL finished,NSInteger finishCount) {
            self.finished = finished;
            self.finishedBlock(finished,finishCount);
        }];
  }];

}

// 贵族面具动画添加到队列
-(void)addOperationWithMarkAnimView{

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _markAnimView.model = _model;
        _markAnimView.originFrame = _markAnimView.frame;
        [self.markAnimlistView addSubview:_markAnimView];
        
        [self.markAnimView animateWithCompleteBlock:^(BOOL finished,NSInteger finishCount) {
            self.finished = finished;
            self.finishedBlock(finished,finishCount);
        }];
  }];

}

#pragma mark -  手动触发 KVO
- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

@end
