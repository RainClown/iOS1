//
//  DeviceCell.m
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/5/3.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "DeviceCell.h"
#import "MyDevice.h"
@interface DeviceCell()

@end

@implementation DeviceCell

-(void)setData:(MyDevice *)data{
    _data =data;
    /*
     @property(nonatomic,copy) NSString * ASSET_TYPE;//设备类型
     @property(nonatomic,copy) NSString * ASSET_IP;//设备IP
     @property(nonatomic,copy) NSNumber * SCORE;//得分
     @property(nonatomic,copy) NSString * TARGET_END_DATE;//扫描时间
     @property(nonatomic,copy) NSString * SCAN_LEVEL;//安全级别 0安全 1高危 2中危 3低危
     @property(nonatomic,copy) NSString * ASSET_NAME;//设备名称
     
     @property (weak, nonatomic) IBOutlet UIImageView *imageType;
     @property (weak, nonatomic) IBOutlet UILabel *deviceName;
     @property (weak, nonatomic) IBOutlet UILabel *deviceType;
     @property (weak, nonatomic) IBOutlet UILabel *deviceIp;
     @property (weak, nonatomic) IBOutlet UILabel *deviceScore;
     */
    self.deviceName.text = data.ASSET_NAME.description;
    self.deviceIp.text   = data.ASSET_IP;
    self.deviceScore.text = data.SCORE.description;
    self.deviceType.text = data.ASSET_TYPE.description;
    //根据安全级别 设置不同对应的图片
    int a = [data.SCAN_LEVEL intValue];
    switch (a) {
        case 0:
            self.imageType.image = [UIImage imageNamed:@"top_device_safe.png"];
            break;
        case 1:
            self.imageType.image = [UIImage imageNamed:@"top_device_high.png"];
            break;
        case 2:
            self.imageType.image = [UIImage imageNamed:@"top_device_mid.png"];
            break;
        case 3:
            self.imageType.image = [UIImage imageNamed:@"top_device_low.png"];
            break;
            
        default:
            break;
    }
    
    
    /*
    if([_data.SCAN_LEVEL isEqual:@0]){
        [self.imageType setImage:[UIImage imageNamed:@"top_device_safe.png"]];
    }else if([_data.SCAN_LEVEL isEqual:@1]){
        [self.imageType setImage:[UIImage imageNamed:@"top_device_high.png"]];
    }else if([_data.SCAN_LEVEL isEqual:@2]){
        [self.imageType setImage:[UIImage imageNamed:@"top_device_mid.png"]];
    }else{
        [self.imageType setImage:[UIImage imageNamed:@"top_device_low.png"]];
    }
    */
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
