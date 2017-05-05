//
//  MZAnimOperationManager.m
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

#import "MZAnimOperationManager.h"
#import "MZLiveGiftAnimationHeader.h"
#import "MZAnimOperation.h"

@interface MZAnimOperationManager ()
/// 普通动画队列1
@property (nonatomic,strong) NSOperationQueue *queue1;
/// 普通动画队列2
@property (nonatomic,strong) NSOperationQueue *queue2;
/// 普通动画队列3
@property (nonatomic,strong) NSOperationQueue *queue3;

/// 从右边动画队列
@property (nonatomic,strong) NSOperationQueue *rightQueue;

/// 贵族面具动画队列
@property (nonatomic,strong) NSOperationQueue *markQueue;
/// 海洋之星动画队列
@property (nonatomic,strong) NSOperationQueue *oceanQueue;
/// 女皇的城堡动画队列
@property (nonatomic,strong) NSOperationQueue *castleQueue;

/// 礼物操作缓存池
@property (nonatomic,strong) NSCache *operationCache;

/// 维护礼物信息的同一用户同一个类型的礼物
@property (nonatomic,strong) NSCache *userGigtInfos;


@end

@implementation MZAnimOperationManager

+ (instancetype)sharedManager
{
    static MZAnimOperationManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MZAnimOperationManager alloc] init];
        
    });
    return manager;
}

/// 动画操作 
- (void)animWithGiftModel:(MZGiftModel *)model finishedBlock:(void(^)(BOOL result))finishedBlock{
   
   //必须要有发送礼物用户信息和礼物个数
   if (model.giftCount == 0 && model.user.userId == 0 && model.giftId == 0) {
        NSLog(@"必须要有发送礼物用户信息和礼物个数");
        finishedBlock(NO);
      return; 
   }
   
   if (model.user.userName.length == 0) {
      NSLog(@"发送礼物者的名字不能为空");
     finishedBlock(NO);
      return; 
   }
   
   if (model.giftType == GIFT_TYPE_DEFAULT && model.giftPic.length == 0) {
     NSLog(@"当是普通动画的时候，需要带上礼物的头像");
     finishedBlock(NO);
     return; 
   }
   
   if (model.giftType == GIFT_TYPE_DEFAULT) { //普通动画
        
        [self animPresentView:model finishedBlock:^(BOOL result) {
            finishedBlock(result);
        }];
        
   }else if (model.giftType == GIFT_TYPE_GUARD) { //爱心守护者
   
      [self animWithGuard:model finishedBlock:^(BOOL result) {
            finishedBlock(result);
      }];
   
   }else if (model.giftType == GIFT_TYPE_MASK) {  //贵族面具
   
      [self animWithMask:model finishedBlock:^(BOOL result) {
            finishedBlock(result);
        }];
   
   }else if (model.giftType == GIFT_TYPE_OCEAN) { //海洋之星
   
      [self animWithOcean:model finishedBlock:^(BOOL result) {
            finishedBlock(result);
      }];
   
   }else if (model.giftType == GIFT_TYPE_COOFFEE) { //咖啡印记
   
      [self animWithCooffee:model finishedBlock:^(BOOL result) {
            finishedBlock(result);
      }];
   
   }else if (model.giftType == GIFT_TYPE_CASTLE) { //女皇的城堡
      
      [self animWithCastle:model finishedBlock:^(BOOL result) {
            finishedBlock(result);
      }];
   }else if (model.giftType == GIFT_TYPE_BURSTS) { //连发动画
      
      [self animBurstsView:model finishedBlock:^(BOOL result) {
            finishedBlock(result);
      }];
   }
}




/// 取消上一次的动画操作
- (void)cancelOperationWithLastGift:(MZGiftModel *)model{
    
    // 当上次为空时就不执行取消操作 (第一次进入执行时才会为空)
  
    if (model.user.userId > 0) {
       NSString *userReuseIdentifierID = [self getUserReuseIdentifierID:model];
        [[self.operationCache objectForKey:userReuseIdentifierID] cancel];
    }
}

// 获得用户唯一标示reuseIdentifier，记录礼物信息的标示信息
-(NSString *)getUserReuseIdentifierID:(MZGiftModel *)model{
  
  NSString *userReuseIdentifierID = [NSString stringWithFormat:@"%ld_%ld",model.user.userId,model.giftId];
  return userReuseIdentifierID; 
  
}

#pragma mark - lazy 加载

- (NSOperationQueue *)queue1
{
    if (_queue1==nil) {
        _queue1 = [[NSOperationQueue alloc] init];
        _queue1.maxConcurrentOperationCount = 1;
        
    }
    return _queue1;
}

- (NSOperationQueue *)queue2
{
    if (_queue2==nil) {
        _queue2 = [[NSOperationQueue alloc] init];
        _queue2.maxConcurrentOperationCount = 1;
    }
    return _queue2;
}

- (NSOperationQueue *)queue3
{
    if (_queue3==nil) {
        _queue3 = [[NSOperationQueue alloc] init];
        _queue3.maxConcurrentOperationCount = 1;
    }
    return _queue3;
}

- (NSOperationQueue *)rightQueue
{
    if (_rightQueue==nil) {
        _rightQueue = [[NSOperationQueue alloc] init];
        _rightQueue.maxConcurrentOperationCount = 1;
    }
    return _rightQueue;
}

-(NSOperationQueue *)markQueue{
    
    if (_markQueue==nil) {
        _markQueue = [[NSOperationQueue alloc] init];
        _markQueue.maxConcurrentOperationCount = 1;
    }
    return _markQueue;
}

-(NSOperationQueue *)oceanQueue{
    
    if (_oceanQueue==nil) {
        _oceanQueue = [[NSOperationQueue alloc] init];
        _oceanQueue.maxConcurrentOperationCount = 1;
    }
    return _oceanQueue;
}


-(NSOperationQueue *)castleQueue{
    
    if (_castleQueue==nil) {
        _castleQueue = [[NSOperationQueue alloc] init];
        _castleQueue.maxConcurrentOperationCount = 1;
    }
    return _castleQueue;
}
- (NSCache *)operationCache
{
    if (_operationCache==nil) {
        _operationCache = [[NSCache alloc] init];
    }
    return _operationCache;
}

- (NSCache *)userGigtInfos {
    if (_userGigtInfos == nil) {
        _userGigtInfos = [[NSCache alloc] init];
    }
    return _userGigtInfos;
}


-(void)resetDealloc
{

  if (_queue1 != nil) {
      _queue1 = nil;
  }
  
  if (_queue2 != nil) {
      _queue2 = nil;
  }
  
   if (_queue3 != nil) {
      _queue3 = nil;
  }
  
  if (_rightQueue!= nil) {
    _rightQueue = nil;
  }
  
  if (_markQueue!= nil) {
    _markQueue = nil;
  }
  
  if (_oceanQueue!= nil) {
     
      _oceanQueue = nil; 
 }
  
  if (_castleQueue!=nil) {
    _castleQueue = nil;
  } 
  
  if (_operationCache != nil) {
      _operationCache = nil;
  }
  
  if (_userGigtInfos != nil) {
      _userGigtInfos = nil;
  }
  

  if (_parentView != nil) {
    _parentView = nil;  
  }
}

//释放内存
-(void)dealloc{
   [self resetDealloc];  
}
#pragma mark - 私有方法 

/**
 普通动画

 @param model 礼物模型
 */
-(void)animPresentView:(MZGiftModel *)model  finishedBlock:(void(^)(BOOL result))finishedBlock{


  NSString *userReuseIdentifierID = [self getUserReuseIdentifierID:model];
   
    // 在有用户礼物信息时
    if ([self.userGigtInfos objectForKey:userReuseIdentifierID]) {
        // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.presentView.giftCount = model.giftCount;
            [op.presentView shakeNumberLabel];
            return;
        }
         // 没有操作缓存，创建op
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        
        // 注意：下面两句代码是和无用户礼物信息时不同的，其余的逻辑一样
        op.presentView.animCount = [[self.userGigtInfos objectForKey:userReuseIdentifierID] integerValue];
        op.model.giftCount = op.presentView.animCount + 1;
        
        op.listView = self.parentView;
        int x =  [self getRandomNumber:1 to:3];
        op.index = x;
        
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
         // 根据用户ID 控制显示的位置
        if (op.index == GIFT_INDEX_queue3) {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue3OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue3 addOperation:op];
            }
        }else if (op.index == GIFT_INDEX_queue2) {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue2OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue2 addOperation:op];
            }
        }else {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue1OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue1 addOperation:op];
            }
        }
    }
    
    // 在没有用户礼物信息时
    else
    {   // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.presentView.giftCount = model.giftCount;
            [op.presentView shakeNumberLabel];
            return;
        }
        
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        
        op.listView = self.parentView;
        int x =  [self getRandomNumber:1 to:3];
        op.index = x;
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
         if (op.index == GIFT_INDEX_queue3) {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue3OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue3 addOperation:op];
            }
        }else if (op.index == GIFT_INDEX_queue2) {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue2OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue2 addOperation:op];
            }
        }else {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue1OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue1 addOperation:op];
            }
        }
    
    }

}

/**
 连发动画

 @param model 礼物模型
 */
-(void)animBurstsView:(MZGiftModel *)model  finishedBlock:(void(^)(BOOL result))finishedBlock{


  NSString *userReuseIdentifierID = [self getUserReuseIdentifierID:model];
   
    // 在有用户礼物信息时
    if ([self.userGigtInfos objectForKey:userReuseIdentifierID]) {
        // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.presentView.giftCount = model.giftCount;
            [op.presentView shakeNumberLabel];
            return;
        }
         // 没有操作缓存，创建op
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        
        // 注意：下面两句代码是和无用户礼物信息时不同的，其余的逻辑一样
        op.presentView.animCount = [[self.userGigtInfos objectForKey:userReuseIdentifierID] integerValue];
        op.model.giftCount = op.presentView.animCount + 1;
        
        op.listView = self.parentView;
        int x =  [self getRandomNumber:1 to:3];
        op.index = x;
        
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
         // 根据用户ID 控制显示的位置
        if (op.index == GIFT_INDEX_queue3) {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue3OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue3 addOperation:op];
            }
        }else if (op.index == GIFT_INDEX_queue2) {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue2OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue2 addOperation:op];
            }
        }else {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue1OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue1 addOperation:op];
            }
        }
    }
    
    // 在没有用户礼物信息时
    else
    {   // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.presentView.giftCount = model.giftCount;
            [op.presentView shakeNumberLabel];
            return;
        }
        
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        
        op.listView = self.parentView;
        int x =  [self getRandomNumber:1 to:3];
        op.index = x;
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
         if (op.index == GIFT_INDEX_queue3) {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue3OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue3 addOperation:op];
            }
        }else if (op.index == GIFT_INDEX_queue2) {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue2OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue2 addOperation:op];
            }
        }else {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-KLivePresentViewWidth, kLiveQueue1OriginY, KLivePresentViewWidth, KLivePresentViewHight);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue1 addOperation:op];
            }
        }
    
    }

}

//贵族面具
-(void) animWithMask:(MZGiftModel *)model finishedBlock:(void (^)(BOOL))finishedBlock{


 NSString *userReuseIdentifierID = [self getUserReuseIdentifierID:model];
   
    // 在有用户礼物信息时
    if ([self.userGigtInfos objectForKey:userReuseIdentifierID]) {
        // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.markAnimView.giftCount = model.giftCount;
            [op.markAnimView shakeNumberLabel];
            return;
        }
         // 没有操作缓存，创建op
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        
        // 注意：下面两句代码是和无用户礼物信息时不同的，其余的逻辑一样
        op.markAnimView.animCount = [[self.userGigtInfos objectForKey:userReuseIdentifierID] integerValue];
        op.model.giftCount = op.markAnimView.animCount + 1;

        op.markAnimlistView = self.parentView;
        op.index = GIFT_INDEX_markQueue;
        
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
        // 根据用户ID 控制显示的位置
        if (op.model.giftCount != 0) {
            op.markAnimView.frame  = self.parentView.frame;
            op.markAnimView.originFrame = op.markAnimView.frame;
            [self.markQueue addOperation:op];
        }
    }
    
    // 在没有用户礼物信息时
    else
    {   // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.markAnimView.giftCount = model.giftCount;
            [op.markAnimView shakeNumberLabel];
            return;
        }
        
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        op.markAnimlistView = self.parentView;
        op.index = GIFT_INDEX_markQueue;
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
        if (op.model.giftCount != 0) {
            op.markAnimView.frame  = self.parentView.frame;
            op.markAnimView.originFrame = op.markAnimView.frame;
            [self.markQueue addOperation:op];
        }
    
    }



}

//爱心守护者
-(void) animWithGuard:(MZGiftModel *)model finishedBlock:(void (^)(BOOL))finishedBlock{
  [self animWithRightAnimView:model finishedBlock:^(BOOL result) {
            finishedBlock(result);
      }];

}

//海洋之星
-(void) animWithOcean:(MZGiftModel *)model finishedBlock:(void (^)(BOOL))finishedBlock{

 NSString *userReuseIdentifierID = [self getUserReuseIdentifierID:model];
   
    // 在有用户礼物信息时
    if ([self.userGigtInfos objectForKey:userReuseIdentifierID]) {
        // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.oceanAnimView.giftCount = model.giftCount;
            [op.oceanAnimView shakeNumberLabel];
            return;
        }
         // 没有操作缓存，创建op
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        
        // 注意：下面两句代码是和无用户礼物信息时不同的，其余的逻辑一样
        op.oceanAnimView.animCount = [[self.userGigtInfos objectForKey:userReuseIdentifierID] integerValue];
        op.model.giftCount = op.oceanAnimView.animCount + 1;

        op.oceanAnimlistView = self.parentView;
        op.index = GIFT_INDEX_oceanQueue;
        
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
        // 根据用户ID 控制显示的位置
        if (op.model.giftCount != 0) {
            op.oceanAnimView.frame  = self.parentView.frame;
            op.oceanAnimView.originFrame = op.oceanAnimView.frame;
            [self.oceanQueue addOperation:op];
        }
    }
    
    // 在没有用户礼物信息时
    else
    {   // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.oceanAnimView.giftCount = model.giftCount;
            [op.oceanAnimView shakeNumberLabel];
            return;
        }
        
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        op.oceanAnimlistView = self.parentView;
        op.index = GIFT_INDEX_oceanQueue;
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
        if (op.model.giftCount != 0) {
            op.oceanAnimView.frame  = self.parentView.frame;
            op.oceanAnimView.originFrame = op.oceanAnimView.frame;
            [self.oceanQueue addOperation:op];
        }
    
    }

}

//咖啡印记
-(void) animWithCooffee:(MZGiftModel *)model finishedBlock:(void (^)(BOOL))finishedBlock{
     [self animWithRightAnimView:model finishedBlock:^(BOOL result) {
            finishedBlock(result);
      }];
}

//女皇的城堡
-(void) animWithCastle:(MZGiftModel *)model finishedBlock:(void (^)(BOOL))finishedBlock{

 NSString *userReuseIdentifierID = [self getUserReuseIdentifierID:model];
   
    // 在有用户礼物信息时
    if ([self.userGigtInfos objectForKey:userReuseIdentifierID]) {
        // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.castleAnimView.giftCount = model.giftCount;
            [op.castleAnimView shakeNumberLabel];
            return;
        }
         // 没有操作缓存，创建op
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        
        // 注意：下面两句代码是和无用户礼物信息时不同的，其余的逻辑一样
        op.castleAnimView.animCount = [[self.userGigtInfos objectForKey:userReuseIdentifierID] integerValue];
        op.model.giftCount = op.castleAnimView.animCount + 1;

        op.castleAnimlistView = self.parentView;
        op.index = GIFT_INDEX_castleQueue;
        
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
        // 根据用户ID 控制显示的位置
        if (op.model.giftCount != 0) {
            op.castleAnimView.frame  = self.parentView.frame;
                  op.castleAnimView.originFrame = op.castleAnimView.frame;
            [self.castleQueue addOperation:op];
        }
    }
    
    // 在没有用户礼物信息时
    else
    {   // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.castleAnimView.giftCount = model.giftCount;
            [op.castleAnimView shakeNumberLabel];
            return;
        }
        
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        op.castleAnimlistView = self.parentView;
        op.index = GIFT_INDEX_castleQueue;
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
        if (op.model.giftCount != 0) {
            op.castleAnimView.frame  =  self.parentView.frame;
            op.castleAnimView.originFrame = op.castleAnimView.frame;
            [self.castleQueue addOperation:op];
        }
    
    }



}


/// 右边动画
- (void)animWithRightAnimView:(MZGiftModel *)model finishedBlock:(void (^)(BOOL))finishedBlock{

 NSString *userReuseIdentifierID = [self getUserReuseIdentifierID:model];
   
    // 在有用户礼物信息时
    if ([self.userGigtInfos objectForKey:userReuseIdentifierID]) {
        // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.rightAnimView.giftCount = model.giftCount;
            [op.rightAnimView shakeNumberLabel];
            return;
        }
         // 没有操作缓存，创建op
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        
        // 注意：下面两句代码是和无用户礼物信息时不同的，其余的逻辑一样
        op.rightAnimView.animCount = [[self.userGigtInfos objectForKey:userReuseIdentifierID] integerValue];
        op.model.giftCount = op.rightAnimView.animCount + 1;

        op.rightAnimlistView = self.parentView;
        op.index = GIFT_INDEX_rightQueue;
        
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
        // 根据用户ID 控制显示的位置
        if (op.model.giftCount != 0) {
            op.rightAnimView.frame  = CGRectMake(SCREEN_WIDTH, KLiveRightAnimViewWidthOriginY, KLiveRightAnimViewWidth, KLiveRightAnimViewHight);
            op.rightAnimView.originFrame = op.rightAnimView.frame;
            [self.rightQueue addOperation:op];
        }
    }
    
    // 在没有用户礼物信息时
    else
    {   // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userReuseIdentifierID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userReuseIdentifierID];
            op.rightAnimView.giftCount = model.giftCount;
            [op.rightAnimView shakeNumberLabel];
            return;
        }
        
        MZAnimOperation *op = [MZAnimOperation animOperationWithGiftModel:model finishedBlock:^(BOOL result,NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userReuseIdentifierID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userReuseIdentifierID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userReuseIdentifierID];
            });
            
        }];
        op.rightAnimlistView = self.parentView;
        op.index = GIFT_INDEX_rightQueue;
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userReuseIdentifierID];
        
        if (op.model.giftCount != 0) {
            op.rightAnimView.frame  = CGRectMake(SCREEN_WIDTH, KLiveRightAnimViewWidthOriginY, KLiveRightAnimViewWidth, KLiveRightAnimViewHight);
            op.rightAnimView.originFrame = op.rightAnimView.frame;
            [self.rightQueue addOperation:op];
        }
    
    }


}

/**
*  取一个随机整数，范围在[from,to），包括from，包括to
*/
-(int)getRandomNumber:(int)from to:(int)to

{
    return (int)(from + (arc4random() % (to - from + 1)));

}


@end
