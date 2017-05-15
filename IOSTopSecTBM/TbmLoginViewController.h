//
//  TbmLoginViewController.h
//  IOSTopSecTBM
//
//  Created by www.topsec.com.cn on 16/3/1.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "AFNetworking.h"
@interface TbmLoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
    NSString *loginip_name;
    NSString *loginport_name;
    
    NSString *tbm_user_name;
    NSString *tbm_user_password;
    NSString *rember_userinfo;
}
-(void)textFieldDidChange:(UITextField*)textField;
@end
