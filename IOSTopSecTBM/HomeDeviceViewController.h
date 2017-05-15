//
//  HomeDeviceViewController.h
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/3/28.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDeviceViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)UIImageView      *Topbg;//1/13
@property(nonatomic,strong)UILabel          *Toptext;
#pragma mark 主体控件
@property (nonatomic,strong ) UITableView *tableView;

@end
