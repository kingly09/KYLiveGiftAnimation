# 前言

最近直播很火，工作最近做了直播，但我们主要是直播电商的方面的，因为是直播方面，产品会有功能都会去借鉴直播秀场的一些，譬如连麦功能、私聊、聊天室、点亮、推送、内购、充值、提现、弹幕、普通礼物、豪华礼物、红包、排行榜等其他功能，我在此整理了，关于直播类app普通礼物和豪华礼物的整理几个礼物动画效果，和大家分享交流一下。如果不完善地方，请提交一个[**issue**](https://github.com/kingly09/KYLiveGiftAnimation/issues/new)。

# 效果

![](https://raw.githubusercontent.com/kingly09/KYLiveGiftAnimation/master/anim.gif)

UI设计师给出flash动画的实现效果图，与切图，动画的时间轴，每个动画执行的时长，标号对应动画的距离，技术根据动画的进场顺序和时长，结合GCD依次渲染动画，程序在加载图片和实现动画中要特别注意内存和CPU占用。

# 动画时间轴

以海洋之星动画为例：

![](https://raw.githubusercontent.com/kingly09/KYLiveGiftAnimation/master/海洋之星打赏.jpg)

