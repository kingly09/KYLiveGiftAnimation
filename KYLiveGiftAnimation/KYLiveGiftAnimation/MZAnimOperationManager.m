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
#import "MZAnimOperation.h"

@interface MZAnimOperationManager ()
/// 队列1
@property (nonatomic,strong) NSOperationQueue *queue1;
/// 队列2
@property (nonatomic,strong) NSOperationQueue *queue2;

/// 操作缓存池
@property (nonatomic,strong) NSCache *operationCache;

/// 维护用户礼物信息
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

   NSString *userID = [NSString stringWithFormat:@"%ld",model.userId];
    // 在有用户礼物信息时
    if ([self.userGigtInfos objectForKey:userID]) {
        // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userID];
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
            [self.userGigtInfos setObject:@(finishCount) forKey:userID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userID];
            });
            
        }];
        
        // 注意：下面两句代码是和无用户礼物信息时不同的，其余的逻辑一样
        op.presentView.animCount = [[self.userGigtInfos objectForKey:userID] integerValue];
        op.model.giftCount = op.presentView.animCount + 1;
        
        op.listView = self.parentView;
        op.index = [userID integerValue] % 2;
        
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userID];
        
        // 根据用户ID 控制显示的位置
        if ([userID integerValue] % 2) {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-self.parentView.frame.size.width / 2, 300, self.parentView.frame.size.width / 2, 40);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue1 addOperation:op];
            }
        }else {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-self.parentView.frame.size.width / 2, 240, self.parentView.frame.size.width / 2, 40);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue2 addOperation:op];
            }
        }
    }
    
    // 在没有用户礼物信息时
    else
    {   // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userID]!=nil) {
            MZAnimOperation *op = [self.operationCache objectForKey:userID];
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
            [self.userGigtInfos setObject:@(finishCount) forKey:userID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userID];
            });
            
        }];
        op.listView = self.parentView;
        op.index = [userID integerValue] % 2;
        // 将操作添加到缓存池
        [self.operationCache setObject:op forKey:userID];
        
        if ([userID integerValue] % 2) {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-self.parentView.frame.size.width / 2, 300, self.parentView.frame.size.width / 2, 40);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue1 addOperation:op];
            }
        }else {
            
            if (op.model.giftCount != 0) {
                op.presentView.frame  = CGRectMake(-self.parentView.frame.size.width / 2, 240, self.parentView.frame.size.width / 2, 40);
                op.presentView.originFrame = op.presentView.frame;
                [self.queue2 addOperation:op];
            }
        }
    
    }
    


}

/// 取消上一次的动画操作
- (void)cancelOperationWithLastGift:(MZGiftModel *)model{
    
    // 当上次为空时就不执行取消操作 (第一次进入执行时才会为空)
    if (model.userId > 0) {
        [[self.operationCache objectForKey:[NSString stringWithFormat:@"%ld",model.userId]] cancel];
    }
}

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

@end
