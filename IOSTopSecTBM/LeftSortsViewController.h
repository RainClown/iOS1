//
//  LeftSortsViewController.h
//  IOSTopSecTBM
//
//  Created by topsec on 16/4/11.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"
#import "UserInformationViewController.h"
#import "ListViewController.h"
@interface LeftSortsViewController : UIViewController
@property (nonatomic,strong) UITableView *tableview;
//增加NavigationController 声明
@property (nonatomic,strong) UINavigationController *navController;


@end
