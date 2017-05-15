//
//  UserInformationViewController.m
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/4/25.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "UserInformationViewController.h"

@interface UserInformationViewController ()

@end

@implementation UserInformationViewController
@synthesize Topbg;
@synthesize backbg;
@synthesize Toptext;
//主体内容
@synthesize userLable;
@synthesize userDate;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:245.0/255.0 blue:253.0/255.0 alpha:100];
    // Do any additional setup after loading the view from its nib.
    /*
     该部分代表 头部标签
     */
    //头部背景
    Topbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/12)];
    Topbg.backgroundColor = [UIColor redColor];
    [self.view addSubview:Topbg];
    //头部返回图标
    int backimage_y = ((self.view.frame.size.height/12)-(self.view.frame.size.height/16))/2;
    backbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, backimage_y, self.view.frame.size.height/8, self.view.frame.size.height/16)];
    [backbg setImage:[UIImage imageNamed:@"backimage"]];
    [self.view addSubview:backbg];
    backbg.userInteractionEnabled = YES;
    //必须为YES才能响应事件
    UITapGestureRecognizer *backTouch=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTouchevent:)];
    [backbg addGestureRecognizer:backTouch];
    //头部title
    CGRect recc = [[UIScreen mainScreen] bounds];
    CGSize topsize = recc.size;
    CGFloat topwide = topsize.width;
    Toptext = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, topwide, self.view.frame.size.height/12)];
    Toptext.text= @"账号管理";
    Toptext.textColor = [UIColor whiteColor];
    [Toptext setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    Toptext.textAlignment = NSTextAlignmentCenter;
    [Topbg addSubview:Toptext];
    
    //主体内容
    //获取是否存储的信息
    NSUserDefaults *ipor = [NSUserDefaults standardUserDefaults];
    NSString   *tbm_user_name = [ipor objectForKey:@"tbm_user"];
    NSString   *tbm_login_time = [ipor objectForKey:@"tbm_login_time"];
    userLable.text = tbm_user_name;
    userDate.text = tbm_login_time;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//返回事件操作
-(void)backTouchevent:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//操作事件  账号切换  退出按钮
-(IBAction)loginButton:(id)sender{
    TbmLoginViewController *loginview = [[TbmLoginViewController alloc]init];
    [self presentViewController:loginview animated:YES completion:nil];

}
-(IBAction)exitButton:(id)sender{
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0){//判断系统版本
        NSLog(@"新系统");
        NSString *title = NSLocalizedString(@"提示", nil);
        NSString *message = NSLocalizedString(@"确定要退出吗！", nil);
        NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        
        UIAlertController *alertControllertbbm = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelActiontbm = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            NSLog(@"取消");
        }];
        UIAlertAction *otherActiontbm = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self exitApplicationTbm];
        }];
        
        [alertControllertbbm addAction:cancelActiontbm];
        [alertControllertbbm addAction:otherActiontbm];
        [self presentViewController:alertControllertbbm animated:YES completion:nil];
        
        
    }else{
        NSLog(@"旧系统");
        UIAlertView *exitAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要退出吗！"delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        exitAlert.tag = 1;
        [exitAlert show];
    }


}
//退出程序app
-(void)exitApplicationTbm{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    
    
    
}
@end
