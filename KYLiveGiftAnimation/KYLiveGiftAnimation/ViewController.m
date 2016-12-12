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
  self.view.backgroundColor = [UIColor grayColor];
  
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
    long  x = arc4random() % 9+1;    
    MZGiftModel *giftModel = [[MZGiftModel alloc] init];
    giftModel.headImage = [UIImage imageNamed:@"luffy"];
    giftModel.userId = x;
    giftModel.userName = [NSString stringWithFormat:@"%ld",x];
    giftModel.giftImage = [UIImage imageNamed:@"flower"];
    giftModel.giftName = @"1个【鲜花】";
    giftModel.giftCount = 1;
    
   if (manager) {
      manager.parentView = self.view;
      // model 传入礼物模型
      [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
        
    }];
  }
  
}

- (IBAction)sendGift02:(id)sender {

    // 礼物模型
    long  x = arc4random() % 9 + 100;    
    MZGiftModel *giftModel = [[MZGiftModel alloc] init];
    giftModel.headImage = [UIImage imageNamed:@"mogu"];
    giftModel.userId = x;
    giftModel.userName = [NSString stringWithFormat:@"%ld",x];
    giftModel.giftImage = [UIImage imageNamed:@"ic_bear_small_14th"];
    giftModel.giftName = @"2个【小熊】";
    giftModel.giftCount = 20;
    
  if (manager) {
    manager.parentView = self.view;
    // model 传入礼物模型
    [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
      
    }];
  }


}

- (IBAction)senderGift03:(id)sender {
  
  // 礼物模型
  long  x = arc4random() % 9+10;    
  MZGiftModel *giftModel = [[MZGiftModel alloc] init];
  giftModel.headImage = [UIImage imageNamed:@"luffy"];
  giftModel.userId = x;
  giftModel.userName = [NSString stringWithFormat:@"%ld",x];
  giftModel.giftImage = [UIImage imageNamed:@"ic_soap_small_14th"];
  giftModel.giftName = @"甜蜜棒棒糖";
  giftModel.giftCount = 9999;
  
  
  if (manager) {
    manager.parentView = self.view;
    // model 传入礼物模型
    [manager animWithGiftModel:giftModel finishedBlock:^(BOOL result) {
      
    }];
  }
  
}
//咖啡印记
- (IBAction)sendCoffee:(id)sender {


}
//爱心守护者
- (IBAction)sendLover:(id)sender {


}
//贵族面具
- (IBAction)sendMask:(id)sender {


}
//海洋之星
- (IBAction)sendOcean:(id)sender {


}
// 女皇的城堡
- (IBAction)sendCastle:(id)sender {


}

// 模拟收到礼物消息的回调
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}



@end
