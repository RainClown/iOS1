//
//  ServerIpViewController.h
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/3/10.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TbmLoginViewController.h"
#import "MBProgressHUD.h"
@interface ServerIpViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIImageView      *Topbg;//1/9
@property(nonatomic,strong)UIImageView      *backbg;
@property(nonatomic,strong)UILabel          *Toptext;

@property(nonatomic,strong)UILabel          *servetIptext;
@property(nonatomic,strong)UITextField      *servetIp;
@property(nonatomic,strong)UILabel          *servetPorttext;
@property(nonatomic,strong)UITextField      *servetPort;
@property(nonatomic,strong)UILabel          *textalert;
@property(nonatomic,strong)UIButton         *submitButton;
@property(nonatomic,strong)UIPickerView     *pickview;
@property(nonatomic,strong)UITextField      *textfied;//协议

@end
