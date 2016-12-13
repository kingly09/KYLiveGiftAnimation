//
//  MZAnimationImageCache.m
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

#import "MZAnimationImageCache.h"

@implementation MZAnimationImageCache

+ (instancetype)shareInstance
{
    static MZAnimationImageCache *share;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[MZAnimationImageCache alloc] init];
        
    });
    return share;
}

- (instancetype)init {
    if (self = [super init]) {
       
       //用NSCache持有引用
       
       
    }
    return self;
}

//注意，当收到内存不足警告时，NSCache会自动释放内存。所以每次访问NSCache，即使上一次已经加载过，也需要判断返回值是否为空。
-(UIImage *)getImageWithName:(NSString *)name{
  
  return [UIImage imageNamed:name];
}

@end
