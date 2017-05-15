//
//  DeviceCell.h
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/5/3.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyDevice;
@interface DeviceCell : UITableViewCell


//主体空间内容
@property (strong ,nonatomic)  MyDevice * data;
@property (weak, nonatomic) IBOutlet UIImageView *imageType;
@property (weak, nonatomic) IBOutlet UILabel *deviceName;
@property (weak, nonatomic) IBOutlet UILabel *deviceType;
@property (weak, nonatomic) IBOutlet UILabel *deviceIp;
@property (weak, nonatomic) IBOutlet UILabel *deviceScore;

@end
