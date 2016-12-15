//
//  MZUserInfo.h
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

#import <Foundation/Foundation.h>

@protocol MZUserInfo <NSObject>

@end
/**
 * @class MZUserInfo 用户信息的模型
 */
@interface MZUserInfo : NSObject

@property (nonatomic,assign) long userId;//用户id, 由后台分配
@property (nonatomic,copy)   NSString *userName;//用户昵称
@property (nonatomic,assign) int sex;//1男,2女
@property (nonatomic,copy)   NSString *headPic;//用户头像
@property (nonatomic,copy)   NSString *bgPic;//背景，保留
@property (nonatomic,assign) long birthDay;//生日,保留
@property (nonatomic,copy)   NSString *area;//所在区域
@property (nonatomic,copy)   NSString *intro;//个人介绍
@property (nonatomic,copy)   NSString *address;//联系地址
@property (nonatomic,copy)   NSString *contact;//联系方式
@property (nonatomic,copy)   NSString *phoneNum; //电话



@end
