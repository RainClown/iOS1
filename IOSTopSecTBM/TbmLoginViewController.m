//
//  TbmLoginViewController.m
//  IOSTopSecTBM
//
//  Created by www.topsec.com.cn on 16/3/1.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "TbmLoginViewController.h"
#import "textFieldBackground.h"
#import "ServerIpViewController.h"
#import "MainViewController.h"
@interface TbmLoginViewController ()

@property(nonatomic,strong)UIImageView      *loginbg;
@property(nonatomic,strong)UITextField  *username;
@property(nonatomic,strong)UITextField  *password;
@property(nonatomic,strong)UIButton     *loginButton;
@property(nonatomic,strong)UIButton     *exitButton;
@property(nonatomic,strong)UIView       *background;
@property(nonatomic,strong)UILabel      *remberinfor;
@property(nonatomic,strong)UISwitch     *switchbtn;
@property(nonatomic,strong)UIImageView  *logoimage;
@property(nonatomic,strong)UIImageView  *nameimage;
@property(nonatomic,strong)UIImageView  *passwordimage;
//底部显示内容

@property(nonatomic,strong)UILabel      *bottomleft;
@property(nonatomic,strong)UILabel      *bottommiddle;
@property(nonatomic,strong)UILabel      *bottomright;

//后台交互变量
@property(nonatomic,strong)NSString      *device_apid;//设备唯一标识
@property(nonatomic,strong)NSDictionary  *apdic;

@end

@implementation TbmLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置背景图片
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg_denglu.png"]];
    _loginbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_loginbg setImage:[UIImage imageNamed:@"login_bg_denglu.png"]];
    _loginbg.userInteractionEnabled = YES;
    //必须为YES才能响应事件
    UITapGestureRecognizer *singleTouch=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MakeKeyboardDisappear:)];
    [_loginbg addGestureRecognizer:singleTouch];
    [self.view addSubview:_loginbg];
    //获取是否存储的信息
    NSUserDefaults *ipor = [NSUserDefaults standardUserDefaults];
    loginip_name = [ipor objectForKey:@"server_ip"];
    loginport_name = [ipor objectForKey:@"server_port"];
    tbm_user_name = [ipor objectForKey:@"tbm_user"];
    tbm_user_password = [ipor objectForKey:@"tbm_password"];
    rember_userinfo = [ipor objectForKey:@"rember_user"];//yes 记住密码  其他为不
    NSString *remberok = @"yes";
    /*
     该操作判断手机的屏幕，对5.5寸的屏幕进行单独布局设计  对其他的统一一个布局
     主要是为了避免手机大屏登陆界面布局不合理问题
     414  736
     375  667
     320  568
     320  480
     */
    if([[UIScreen mainScreen]bounds].size.height >= 667){//4.7英寸  5.5英寸
        //logo图片
        _logoimage = [[UIImageView alloc]initWithFrame:CGRectMake(75, 30, self.view.frame.size.width-150, 80)];
        [_logoimage setImage:[UIImage imageNamed:@"logo.png"]];
        [self.view addSubview:_logoimage];
        //用户名和密码的背景
        _background = [[textFieldBackground alloc]initWithFrame:CGRectMake(20, 140, self.view.frame.size.width-40, 100)];
        [_background setBackgroundColor:[UIColor whiteColor]];
        [[_background layer] setCornerRadius:5];
        [[_background layer] setMasksToBounds:YES];
        [self.view addSubview:_background];
        
        //控件 用户名
        _username = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-40, 49)];
        _username.backgroundColor = [UIColor whiteColor];
        _username.contentHorizontalAlignment= UIControlContentHorizontalAlignmentCenter;
        _username.textAlignment= NSTextAlignmentCenter;
        //关闭自动联想 和首字母大写
        [_username setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_username  setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        if([remberok isEqualToString:rember_userinfo]){
            _username.text=tbm_user_name;
        }else{
            _username.placeholder = [NSString stringWithFormat:@"请输入账号"];
        }
        
        _username.layer.cornerRadius= 5.0;
        _username.delegate=self;
        _username.keyboardType=UIKeyboardTypeDefault;
        [_username addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];//设置最大输入11个字符
        [_background addSubview:_username];

        
        _nameimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 35, 35)];
        [_nameimage setImage:[UIImage imageNamed:@"tbmnew_name.png"]];
        [_background addSubview:_nameimage];
  
        
        //控件 密码
        _password =[[UITextField alloc]initWithFrame:CGRectMake(10, 50, self.view.frame.size.width-40, 49)];
        _password.backgroundColor = [UIColor whiteColor];
        _password.contentHorizontalAlignment= UIControlContentHorizontalAlignmentCenter;
        _password.textAlignment= NSTextAlignmentCenter;
        if([remberok isEqualToString:rember_userinfo]){
            _password.text=tbm_user_password;
        }else{
            _password.placeholder = [NSString stringWithFormat:@"请输入密码"];
        }
        _password.layer.cornerRadius= 5.0;
        _password.delegate=self;
        _password.secureTextEntry = YES;//设置成密码格式
        [_password addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];//设置最大输入11个字符
        [_background  addSubview:_password];
        
        _passwordimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 55, 35, 35)];
        [_passwordimage setImage:[UIImage imageNamed:@"tbmnew_password.png"]];
        [_background addSubview:_passwordimage];
        
        //记住密码操作
        _remberinfor = [[UILabel alloc]initWithFrame:CGRectMake(20, 255, 70, 35)];
        _remberinfor.text=@"记住密码";
        _remberinfor.textColor = [UIColor grayColor];
        _remberinfor.textAlignment = NSTextAlignmentLeft;

        _remberinfor.font = [UIFont fontWithName:@"Helvetica" size:15];
        _remberinfor.autoresizesSubviews= true;
        [self.view addSubview:_remberinfor];
        _switchbtn = [[UISwitch alloc]initWithFrame:CGRectMake(100, 255, 0, 0)];
        _switchbtn.transform = CGAffineTransformMakeScale(0.95, 0.95);
        if([remberok isEqualToString:rember_userinfo]){
            [_switchbtn setOn:TRUE];
        }else{
            [_switchbtn setOn:FALSE];
        }
        [self.view addSubview:_switchbtn];
        //控件 登陆按钮
        _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_loginButton setFrame:CGRectMake(20, 310, self.view.frame.size.width-40, 40)];
        [_loginButton setTitle:@"登 陆" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor orangeColor]];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius= 5.0;
        [self.view addSubview:_loginButton];
        [_loginButton addTarget:self action:@selector(SubmitButtonaction:) forControlEvents:UIControlEventTouchUpInside];
        //控件 退出按钮
        _exitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_exitButton setFrame:CGRectMake(20, 365, self.view.frame.size.width-40, 40)];
        [_exitButton setTitle:@"退 出" forState:UIControlStateNormal];
        [_exitButton setBackgroundColor:[UIColor redColor]];
        [_exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _exitButton.layer.cornerRadius= 5.0;
        [self.view addSubview:_exitButton];
        [_exitButton addTarget:self action:@selector(AlertbuttonExit:) forControlEvents:UIControlEventTouchUpInside];
        /**
         *
         底部显示内容  topsec 显示标示与进入服务器设置
         适配不同屏幕
         1242 2208
         750  1334
         640  1136
         640  960
         320  480
         *
         */
        _bottommiddle = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-2,self.view.frame.size.height-50, (self.view.frame.size.width/2-2)*2, 20)];
        _bottommiddle.text=@"|";
        _bottommiddle.textColor=[UIColor whiteColor];
        _bottommiddle.font = [UIFont fontWithName:@"Helvetica" size:15];
        [_bottommiddle center];
        [self.view addSubview:_bottommiddle];
        _bottomleft = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-90,self.view.frame.size.height-50, (self.view.frame.size.width/2-90)*2, 20)];
        _bottomleft.text=@"@基线管理";
        _bottomleft.textColor=[UIColor whiteColor];
        _bottomleft.font = [UIFont fontWithName:@"Helvetica" size:15];
        [_bottomleft center];
        [self.view addSubview:_bottomleft];
        _bottomright = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+15,self.view.frame.size.height-50, (self.view.frame.size.width/2+15)*2, 20)];
        _bottomright.text=@"服务器设置";
        _bottomright.textColor=[UIColor whiteColor];
        _bottomright.font = [UIFont fontWithName:@"Helvetica" size:15];
        [_bottomright center];
        //为UIlable增加点击事件
        _bottomright.userInteractionEnabled = YES;
        UITapGestureRecognizer  *serveripEvent = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ServerSettingLableTouchUpInside:)];
        [_bottomright  addGestureRecognizer:serveripEvent];
        //////////////////////////////////////////////////////////////////////////////////////////
        [self.view addSubview:_bottomright];
        
    }else{
        
        //logo图片
        _logoimage = [[UIImageView alloc]initWithFrame:CGRectMake(75, 30, self.view.frame.size.width-150, 60)];
        [_logoimage setImage:[UIImage imageNamed:@"logo.png"]];
        [self.view addSubview:_logoimage];
        //用户名和密码的背景
        _background = [[textFieldBackground alloc]initWithFrame:CGRectMake(20, 120, self.view.frame.size.width-40, 100)];
        [_background setBackgroundColor:[UIColor whiteColor]];
        [[_background layer] setCornerRadius:5];
        [[_background layer] setMasksToBounds:YES];
        [self.view addSubview:_background];
        
        //控件 用户名
        _username = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-40, 49)];
        _username.backgroundColor = [UIColor whiteColor];
        _username.contentHorizontalAlignment= UIControlContentHorizontalAlignmentCenter;
        _username.textAlignment= NSTextAlignmentCenter;
        //关闭自动联想 和首字母大写
        [_username setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_username  setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        if([remberok isEqualToString:rember_userinfo]){
            _username.text=tbm_user_name;
        }else{
            _username.placeholder = [NSString stringWithFormat:@"请输入账号"];
        }
        _username.layer.cornerRadius= 5.0;
        _username.delegate=self;
        _username.keyboardType=UIKeyboardTypeDefault;
        [_username addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];//设置最大输入11个字符
        [_background addSubview:_username];
        
        _nameimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 35, 35)];
        [_nameimage setImage:[UIImage imageNamed:@"tbmnew_name.png"]];
        [_background addSubview:_nameimage];
        
        //控件 密码
        _password =[[UITextField alloc]initWithFrame:CGRectMake(10, 50, self.view.frame.size.width-40, 49)];
        _password.backgroundColor = [UIColor whiteColor];
        _password.contentHorizontalAlignment= UIControlContentHorizontalAlignmentCenter;
        _password.textAlignment= NSTextAlignmentCenter;
        if([remberok isEqualToString:rember_userinfo]){
            _password.text=tbm_user_password;
        }else{
            _password.placeholder = [NSString stringWithFormat:@"请输入密码"];
        }
        _password.layer.cornerRadius= 5.0;
        _password.delegate=self;
        _password.secureTextEntry = YES;//设置成密码格式
        [_password addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];//设置最大输入11个字符
        [_background  addSubview:_password];

        
        _passwordimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 55, 35, 35)];
        [_passwordimage setImage:[UIImage imageNamed:@"tbmnew_password.png"]];
        [_background addSubview:_passwordimage];
        //记住密码操作
        _remberinfor = [[UILabel alloc]initWithFrame:CGRectMake(20, 225, 70, 35)];
        _remberinfor.text=@"记住密码";
        _remberinfor.textAlignment = NSTextAlignmentLeft;
        _remberinfor.textColor = [UIColor grayColor];
        _remberinfor.font = [UIFont fontWithName:@"Helvetica" size:15];
        _remberinfor.autoresizesSubviews= true;
        [self.view addSubview:_remberinfor];
        _switchbtn = [[UISwitch alloc]initWithFrame:CGRectMake(100, 225, 0, 0)];
        _switchbtn.transform = CGAffineTransformMakeScale(0.95, 0.95);
        if([remberok isEqualToString:rember_userinfo]){
            [_switchbtn  setOn:YES];
        }else{
            [_switchbtn  setOn:NO];
        }
        [self.view addSubview:_switchbtn];
        //控件 登陆按钮
        _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_loginButton setFrame:CGRectMake(20, 270, self.view.frame.size.width-40, 37)];
        [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor orangeColor]];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius= 5.0;
        [self.view addSubview:_loginButton];
        [_loginButton addTarget:self action:@selector(SubmitButtonaction:) forControlEvents:UIControlEventTouchUpInside];
        //控件 退出按钮
        _exitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_exitButton setFrame:CGRectMake(20, 330, self.view.frame.size.width-40, 37)];
        [_exitButton setTitle:@"退 出" forState:UIControlStateNormal];
        [_exitButton setBackgroundColor:[UIColor redColor]];
        [_exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _exitButton.layer.cornerRadius= 5.0;
        [self.view addSubview:_exitButton];
        [_exitButton addTarget:self action:@selector(AlertbuttonExit:) forControlEvents:UIControlEventTouchUpInside];
        /**
         *
         底部显示内容  topsec 显示标示与进入服务器设置
         适配不同屏幕
         1242 2208
         750  1334
         640  1136
         640  960
         320  480
         *
         */
        _bottommiddle = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-2,self.view.frame.size.height-50, (self.view.frame.size.width/2-2)*2, 20)];
        _bottommiddle.text=@"|";
        _bottommiddle.textColor=[UIColor whiteColor];
        _bottommiddle.font = [UIFont fontWithName:@"Helvetica" size:12];
        [_bottommiddle center];
        [self.view addSubview:_bottommiddle];
        _bottomleft = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-70,self.view.frame.size.height-50, (self.view.frame.size.width/2-70)*2, 20)];
        _bottomleft.text=@"@基线管理";
        _bottomleft.textColor=[UIColor whiteColor];
        _bottomleft.font = [UIFont fontWithName:@"Helvetica" size:12];
        [_bottomleft center];
        [self.view addSubview:_bottomleft];
        _bottomright = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+10,self.view.frame.size.height-50, (self.view.frame.size.width/2+10)*2, 20)];
        _bottomright.text=@"服务器设置";
        _bottomright.textColor=[UIColor whiteColor];
        _bottomright.font = [UIFont fontWithName:@"Helvetica" size:12];
        [_bottomright center];
        //为UIlable增加点击事件
        _bottomright.userInteractionEnabled = YES;
        UITapGestureRecognizer  *serveripEvent = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ServerSettingLableTouchUpInside:)];
        [_bottomright  addGestureRecognizer:serveripEvent];
        //////////////////////////////////////////////////////////////////////////////////////////////
        [self.view addSubview:_bottomright];
    }
    
}

-(void)textFieldDidChange:(UITextField *)textField{
    if(textField.text.length>11){
        textField.text = [textField.text substringToIndex:11];
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    return YES;
}
//点击背景隐藏键盘
-(void)MakeKeyboardDisappear:(id)sender
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击登陆按钮  进行事件操作
-(IBAction)SubmitButtonaction:(id)sender{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    
    
    if(loginip_name.length<8 ||loginport_name.length<2){//对服务器是否设置进行判断
        ServerIpViewController *serverview = [[ServerIpViewController alloc]init];
        [self presentViewController:serverview animated:YES completion:nil];
    }else{//对网络
        if([self isConnectionAvailable]){//网络可以用
            //判断输入的用户名和密码 是否为空
            if(_username.text.length>0&&_password.text.length>0){
            #pragma make 网络请求
            [self getLogin];

            }else{
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];//<span style="font-family: Arial, Helvetica, sans-serif;">MBProgressHUD为第三方库，不需要可以省略或使用AlertView</span>
                hud.removeFromSuperViewOnHide =YES;
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"用户名和密码不能为空！";
                hud.minSize = CGSizeMake(132.f, 108.0f);
                [hud hideAnimated:YES afterDelay:2];
            }
        }else{
            NSLog(@"网络不可用！");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];//<span style="font-family: Arial, Helvetica, sans-serif;">MBProgressHUD为第三方库，不需要可以省略或使用AlertView</span>
            hud.removeFromSuperViewOnHide =YES;
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"网络不可用！";
            hud.minSize = CGSizeMake(132.f, 108.0f);
            [hud hideAnimated:YES afterDelay:2];
        }
        
        
        
        
        
        
        
        
        
    }
    /*
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
     // Set the custom view mode to show any view.
     hud.mode = MBProgressHUDModeCustomView;
     // Set an image view with a checkmark.
     UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
     hud.customView = [[UIImageView alloc] initWithImage:image];
     // Looks a bit nicer if we make it square.
     hud.square = YES;
     // Optional label text.
     hud.label.text = NSLocalizedString(@"修改成功", @"HUD done title");
     
     [hud hideAnimated:YES afterDelay:1.f];
     */
}
//点击推出按钮 进行事件操作
-(IBAction)AlertbuttonExit:(id)sender{
    
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

#pragma marks --UIAlertViewDelegate--
//取消按钮
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        
        if(alertView.tag==1){
            [self exitApplicationTbm];
        }
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
//服务器设置按钮
-(void)ServerSettingLableTouchUpInside:(UITapGestureRecognizer *)recognizer{
    ServerIpViewController *serverview = [[ServerIpViewController alloc]init];
    [self presentViewController:serverview animated:YES completion:nil];
}
//网络状态检查
-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:loginip_name];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];//<span style="font-family: Arial, Helvetica, sans-serif;">MBProgressHUD为第三方库，不需要可以省略或使用AlertView</span>
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网络不通，请检查..";
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hideAnimated:YES afterDelay:2];
        return NO;
    }
    
    return isExistenceNetwork;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void) getLogin{
    //增加滚动提示
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"正在登陆";
    hud.minSize = CGSizeMake(132.f, 108.0f);

    //获取沙盒数据
    NSUserDefaults* user=[NSUserDefaults  standardUserDefaults];
    NSString* xieyi=[user objectForKey:@"server_xieyi"];//协议
    NSString* tbm_ip=[user objectForKey:@"server_ip"];//ip
    NSString* tbm_port=[user objectForKey:@"server_port"];//port
    NSLog(@"%@",xieyi);
    if ([xieyi isEqualToString: @"http"]) {
        #pragma mark 设备唯一标识
        NSString * adld =[[[UIDevice currentDevice]identifierForVendor]UUIDString];
        self.device_apid =adld;
        #pragma make 网络请求地址
        NSString* tbm_login_url=[NSString stringWithFormat:@"http://%@:%@/tbmweb/mobile/auth!login.do?username=%@&password=%@&deviceId=%@&encrypt=1",tbm_ip,tbm_port,self.username.text,self.password.text,self.device_apid ];
        //1.创建一个管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //AFN 2.5.4
        /**
         manager.securityPolicy.allowInvalidCertificates = YES;
         
         
         
         **/
        //AFN 2.6.1 包括现在的3.0.4,里面它实现了代理,信任服务器
        manager.securityPolicy.validatesDomainName = NO;
        [manager GET:tbm_login_url
          parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"%@",responseObject);
              //反序列化成字符串 是的做测试
              self.apdic=[NSDictionary dictionaryWithDictionary:responseObject];
               if ([self.apdic[@"status"] isEqual:@1]) {
              NSDictionary* apdata =[NSDictionary   dictionaryWithDictionary:responseObject[@"data"]];
                   //后台返回的token
              //NSString* alert_message = self.apdic[@"msg"];//后台返回的time
              NSString* tokentbm = apdata[@"token"];
              NSString* timetbm  = apdata[@"date"];
              //NSLog(@"什么鸟玩意%@",tokentbm);
              NSUserDefaults* tbm_data=[NSUserDefaults standardUserDefaults];
              [tbm_data setObject:tokentbm forKey:@"tbm_device_token"];
              [tbm_data setObject:timetbm forKey:@"tbm_login_time"];
              [tbm_data setObject:adld forKey:@"tbm_device_id"];
              [tbm_data synchronize];
              NSLog(@"%@",apdata[@"token"]);
             
                  [hud hideAnimated:YES afterDelay:0];//关闭提示框
                  if(_switchbtn.on){
                      NSString *rembber = @"yes";
                      NSUserDefaults *userinformation = [NSUserDefaults standardUserDefaults];
                      NSString *uuname = _username.text;
                      NSString *passname = _password.text;
                      [userinformation setObject:uuname forKey:@"tbm_user"];
                      [userinformation setObject:passname forKey:@"tbm_password"];
                      [userinformation setObject:rembber forKey:@"rember_user"];
                      [userinformation synchronize];
                      NSLog(@"记住密码");
                      
                      //通知
                      //[[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchRnootVCNotificatio" object:nil];
                      #pragma make 主界面
                      MainViewController *homeview = [[MainViewController alloc]init];
                      [self presentViewController:homeview animated:YES completion:nil];
                  }else{
                      NSLog(@"不记住");
                      NSString *rembber = @"no";
                      NSUserDefaults *userinformation = [NSUserDefaults standardUserDefaults];
                      [userinformation setObject:rembber forKey:@"rember_user"];
                      [userinformation synchronize];
                      ////////////////////////////////////////////////////////////////////////////////////////
                      //通知
                      //[[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchRnootVCNotificatio" object:nil];
                      
                      MainViewController *homeview = [[MainViewController alloc]init];
                      [self presentViewController:homeview animated:YES completion:nil];
                  }
                  
              }else{
                  hud.removeFromSuperViewOnHide= YES;
                  hud.mode = MBProgressHUDModeText;
                  hud.label.text = @"登陆失败";
                  hud.minSize = CGSizeMake(132.f, 108.0f);
                  [hud hideAnimated:YES afterDelay:2];
              
              
              }
              //NSLog(@"%@",responseObject);
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"==========%@",error);
              hud.removeFromSuperViewOnHide= YES;
              hud.mode = MBProgressHUDModeText;
              hud.label.text = @"登陆超时";
              hud.minSize = CGSizeMake(132.f, 108.0f);
              [hud hideAnimated:YES afterDelay:2];
          }];
    }
    
    
}


@end
