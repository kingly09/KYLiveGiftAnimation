//
//  ViewController.m
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
// THE SOFTWARE.All rights reserved.
//

#import "ViewController.h"
#import "MZLiveGiftAnimationHeader.h"

@interface ViewController (){
  
  MZAnimOperationManager *manager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.view.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"直播界面"]]; 
  
  manager = [MZAnimOperationManager sharedManager];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
  
  if (manager != nil) {
    [manager resetDealloc];
    manager = nil;
  }
}

-(void)viewWillDisappear:(BOOL)animated {
  
  [super viewWillDisappear:animated];
  
  if (manager != nil) {
    [manager resetDealloc];
    manager = nil;
  }
  
}

- (IBAction)sendGift01:(id)sender {
  
  // 礼物模型
  long  x = [self getRandomNumber:80000 to:90000];    
  MZGiftModel *giftModel = [[MZGiftModel alloc] init];
  giftModel.giftId =  [self getRandomNumber:200 to:300];
  giftModel.headImage = [UIImage imageNamed:@"luffy"];
  giftModel.giftImage = [UIImage imageNamed:@"flower"];
  giftModel.giftPic  = @"https:// xxx";
  giftModel.giftName = @"1个【鲜花】";
  giftModel.giftCount = 1;
  
  
  MZUserInfo *user = [[MZUserInfo alloc] init];
  user.userName = [NSString stringWithFormat:@"用户 %ld",x];
  user.userId   = x;
  user.headPic  = @"https:// xxx";
  giftModel.user = user;
  
  if (manager) {
    manager.parentView = self.view;
    // model 传入礼物模型
    [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
      
    }];
  }
  
}

- (IBAction)sendGift02:(id)sender {
  
  
  long  x = [self getRandomNumber:70000 to:80000];    
  MZGiftModel *giftModel = [[MZGiftModel alloc] init];
  giftModel.giftId = [self getRandomNumber:90 to:100];
  giftModel.headImage = [UIImage imageNamed:@"mogu"];
  giftModel.giftImage = [UIImage imageNamed:@"ic_bear_small_14th"];
  giftModel.giftPic  = @"https:// xxx";
  giftModel.giftName =  @"2个【小熊】";
  giftModel.giftCount = 2;
  
  MZUserInfo *user = [[MZUserInfo alloc] init];
  user.userName = [NSString stringWithFormat:@"用户 %ld",x];
  user.userId   = x;
  user.headPic  = @"https:// xxx";
  giftModel.user = user;
  
  if (manager) {
    manager.parentView = self.view;
    // model 传入礼物模型
    [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
      
    }];
  }
  
  
}

- (IBAction)senderGift03:(id)sender {
  
  // 礼物模型
  long  x = [self getRandomNumber:60000 to:70000];    
  MZGiftModel *giftModel = [[MZGiftModel alloc] init];
  giftModel.giftId = [self getRandomNumber:70 to:80];
  giftModel.headImage = [UIImage imageNamed:@"luffy"];
  giftModel.giftImage = [UIImage imageNamed:@"ic_soap_small_14th"];
  giftModel.giftPic  = @"https:// xxx";
  giftModel.giftName = @"9个香皂";
  giftModel.giftCount = 9;
  giftModel.giftType  = GIFT_TYPE_BURSTS;
  
  MZUserInfo *user = [[MZUserInfo alloc] init];
  user.userName = [NSString stringWithFormat:@"用户 %ld",x];
  user.userId   = x;
  user.headPic  = @"https:// xxx";
  giftModel.user = user;
  
  
  if (manager) {
    manager.parentView = self.view;
    // model 传入礼物模型
    [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
      
    }];
  }
  
}
//咖啡印记
- (IBAction)sendCoffee:(id)sender {
  
  // 礼物模型
  
  
  long  x = [self getRandomNumber:50000 to:60000];    
  
  MZGiftModel *giftModel = [[MZGiftModel alloc] init];
  giftModel.giftId = [self getRandomNumber:50 to:60];
  giftModel.headImage = [UIImage imageNamed:@"luffy"];
  giftModel.giftType = GIFT_TYPE_COOFFEE;
  giftModel.giftPic  = @"https:// xxx";
  giftModel.giftImage = [UIImage imageNamed:@"ic_soap_small_14th"];
  giftModel.giftName = @"咖啡印记";
  giftModel.giftCount = 9999;
  
  MZUserInfo *user = [[MZUserInfo alloc] init];
  user.userName = [NSString stringWithFormat:@"用户 %ld",x];
  user.userId   = x;
  user.headPic  = @"https:// xxx";
  giftModel.user = user;
  
  if (manager) {
    manager.parentView = self.view;
    // model 传入礼物模型
    [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
      
    }];
  }
  
}
//爱心守护者
- (IBAction)sendLover:(id)sender {
  
  // 礼物模型  
  long  x = [self getRandomNumber:40000 to:50000];  
     
  MZGiftModel *giftModel = [[MZGiftModel alloc] init];
  giftModel.giftId = [self getRandomNumber:40 to:50];
  giftModel.headImage = [UIImage imageNamed:@"luffy"];
  giftModel.giftType = GIFT_TYPE_GUARD;
  giftModel.giftPic  = @"https:// xxx";
  giftModel.giftImage = [UIImage imageNamed:@"ic_soap_small_14th"];
  giftModel.giftName = @"爱心守护者";
  giftModel.giftCount = 9999;
  
  MZUserInfo *user = [[MZUserInfo alloc] init];
  user.userName = [NSString stringWithFormat:@"用户 %ld",x];
  user.userId   = x;
  user.headPic  = @"https:// xxx";
  giftModel.user = user;
  
  
  if (manager) {
    manager.parentView = self.view;
    // model 传入礼物模型
    [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
      
    }];
  }
  
}
//贵族面具
- (IBAction)sendMask:(id)sender {
  
  // 礼物模型
  long  x = [self getRandomNumber:30000 to:40000];   
  MZGiftModel *giftModel = [[MZGiftModel alloc] init];
  giftModel.giftId = [self getRandomNumber:30 to:40];
  giftModel.giftType = GIFT_TYPE_MASK;
  giftModel.giftPic  = @"https:// xxx";
  giftModel.giftName = @"贵族面具";
  giftModel.giftCount = 9999;
  
  MZUserInfo *user = [[MZUserInfo alloc] init];
  user.userName = [NSString stringWithFormat:@"用户 %ld",x];
  user.userId   = x;
  user.headPic  = @"https:// xxx";
  giftModel.user = user;
  
  
  if (manager) {
    manager.parentView = self.view;
    // model 传入礼物模型
    [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
      
    }];
  }
  
  
  
}
//海洋之星
- (IBAction)sendOcean:(id)sender {
  
  // 礼物模型
  long  x =  [self getRandomNumber:20000 to:30000];   
  MZGiftModel *giftModel = [[MZGiftModel alloc] init];
  giftModel.giftId = [self getRandomNumber:20 to:30];
  giftModel.headImage = [UIImage imageNamed:@"luffy"];
  giftModel.giftType = GIFT_TYPE_OCEAN;
  giftModel.giftPic  = @"https:// xxx";
  giftModel.giftImage = [UIImage imageNamed:@"ic_soap_small_14th"];
  giftModel.giftName = @"海洋之星";
  giftModel.giftCount = 9999;
  
  MZUserInfo *user = [[MZUserInfo alloc] init];
  user.userName = [NSString stringWithFormat:@"用户 %ld",x];
  user.userId   = x;
  user.headPic  = @"https:// xxx";
  giftModel.user = user;
  
  if (manager) {
    manager.parentView = self.view;
    // model 传入礼物模型
    [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
      
    }];
  }
  
  
  
}
// 女皇的城堡
- (IBAction)sendCastle:(id)sender {
  
  long  x = [self getRandomNumber:10000 to:20000]; 
  // 礼物模型
  MZGiftModel *giftModel = [[MZGiftModel alloc] init];
  giftModel.giftId = [self getRandomNumber:1 to:10];
  giftModel.giftType = GIFT_TYPE_CASTLE;
  giftModel.giftPic  = @"https:// xxx";
  giftModel.giftImage = [UIImage imageNamed:@"ic_soap_small_14th"];
  giftModel.giftName = @"女皇的城堡";
  giftModel.giftCount = 9999;
  
  MZUserInfo *user = [[MZUserInfo alloc] init];
  user.userName = [NSString stringWithFormat:@"用户 %ld",x];
  user.userId   = x;
  user.headPic  = @"https:// xxx";
  giftModel.user = user;
  
  
  if (manager) {
    manager.parentView = self.view;
    // model 传入礼物模型
    [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
      
    }];
  }
  
  
}

// 模拟收到礼物消息的回调
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
}


/**
*  取一个随机整数，范围在[from,to），包括from，包括to
*/
-(long )getRandomNumber:(int)from to:(int)to

{
    return (long)(from + (arc4random() % (to - from + 1)));

}



@end
