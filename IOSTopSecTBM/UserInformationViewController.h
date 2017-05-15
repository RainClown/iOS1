//
//  UserInformationViewController.h
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/4/25.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TbmLoginViewController.h"
#import "MBProgressHUD.h"
@interface UserInformationViewController : UIViewController
@property(nonatomic,strong)UIImageView      *Topbg;//1/9
@property(nonatomic,strong)UIImageView      *backbg;
@property(nonatomic,strong)UILabel          *Toptext;

//主体内容
@property(nonatomic,strong)IBOutlet  UILabel *userLable;
@property(nonatomic,strong)IBOutlet  UILabel *userDate;

-(IBAction)loginButton:(id)sender;
-(IBAction) exitButton:(id)sender;

@end
