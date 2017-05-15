//
//  AppDelegate.h
//  IOSTopSecTBM
//  Created by 刘修吉  on 16/3/08.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//侧边栏 方法
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;

@end

