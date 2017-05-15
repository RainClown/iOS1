//
//  ServerIpViewController.m
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/3/10.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "ServerIpViewController.h"
#define NUMBERS @"0123456789.";//只能输入数字和点
@implementation ServerIpViewController
@synthesize Topbg;
@synthesize backbg;
@synthesize Toptext;
@synthesize servetIptext;
@synthesize servetIp;
@synthesize servetPorttext;
@synthesize servetPort;
@synthesize textalert;
@synthesize submitButton;
@synthesize pickview;
@synthesize textfied;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置背景
    self.view.backgroundColor =[UIColor colorWithWhite:0.9 alpha:1];
    //点击空白隐藏键盘
    self.view.userInteractionEnabled = YES;
    //必须为YES才能响应事件
    UITapGestureRecognizer *singleTouch=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MakeKeyboardDisappear:)];
    [self.view addGestureRecognizer:singleTouch];
    //获取是否存储的信息
    NSUserDefaults *ipset = [NSUserDefaults standardUserDefaults];
    NSString *ip_name = [ipset objectForKey:@"server_ip"];
    NSString *port_name = [ipset objectForKey:@"server_port"];
    NSString *xieyi_name =[ipset objectForKey:@"server_xieyi"];
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
    Toptext = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/12)];
    Toptext.text= @"服务器设置";
    Toptext.textColor = [UIColor whiteColor];
    [Toptext setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    Toptext.textAlignment = NSTextAlignmentCenter;
    [Topbg addSubview:Toptext];
    
    /*
     代表主体部分
     */
    servetIptext = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, self.view.frame.size.width, 20)];
    servetIptext.text= @"服务器地址";
    servetIptext.textColor = [UIColor grayColor];
    [self.view addSubview:servetIptext];
    
    servetIp = [[UITextField alloc] initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, 50)];
    servetIp.backgroundColor = [UIColor whiteColor];
    if(ip_name.length>8){
        servetIp.text = ip_name;
    }else{
        servetIp.placeholder = [NSString stringWithFormat:@"ip地址"];
    }
    servetIp.delegate=self;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 110, 10, 50)];
    servetIp.leftView = view1;
    servetIp.leftViewMode = UITextFieldViewModeAlways;
    
    //增加输入字数个数约束
    servetIp.tag = 1;
    [servetIp addTarget:self action:@selector(textFieldDidChangeip:) forControlEvents:UIControlEventEditingChanged];//设置最大输入15个字符
    servetIp.keyboardType = UIKeyboardTypeDecimalPad;//只能输入0123456789.
    [self.view addSubview:servetIp];
    
    
    servetPorttext = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, self.view.frame.size.width, 20)];
    servetPorttext.text= @"服务器端口";
    servetPorttext.textColor = [UIColor grayColor];
    [self.view addSubview:servetPorttext];
    
    servetPort = [[UITextField alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 50)];
    servetPort.backgroundColor = [UIColor whiteColor];
    if(port_name.length>=2){
        servetPort.text = port_name;
    }else{
        servetPort.placeholder = [NSString stringWithFormat:@"端口"];
    }
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 220, 10, 50)];
    servetPort.leftView = view2;
    servetPort.leftViewMode = UITextFieldViewModeAlways;
    
    //增加输入字数个数约束
    servetPort.tag = 2;
    servetPort.keyboardType = UIKeyboardTypeNumberPad;
    [servetPort addTarget:self action:@selector(textFieldDidChangePort:) forControlEvents:UIControlEventEditingChanged];//设置最大输入4个字符
    [self.view addSubview:servetPort];
    
    
    
    textalert = [[UILabel alloc] initWithFrame:CGRectMake(10, 290, self.view.frame.size.width, 20)];
    textalert.font = [UIFont fontWithName:@"Helvetica" size:12];
    textalert.textColor = [UIColor redColor];
    textalert.text = @"注：请正确输入ip，确保数据传输正常";
    [self.view addSubview:textalert];
    
    
    
    submitButton = [[UIButton alloc]initWithFrame:CGRectMake(10, (self.view.frame.size.height -120), self.view.frame.size.width-20, 40)];
    submitButton.backgroundColor = [UIColor redColor];
    [submitButton setTintColor:[UIColor whiteColor]];
    [submitButton setTitle:@"确定使用" forState:UIControlStateNormal];
    submitButton.layer.cornerRadius= 5.0;
    //增加点击事件
    [submitButton addTarget:self action:@selector(serverSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitButton];
    
    //新增协议
    self.pickview = [[UIPickerView alloc] init];
    self.pickview.dataSource = self;
    self.pickview.delegate = self;
    pickview.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    
    textfied =[[UITextField alloc]initWithFrame:CGRectMake(168, 188, 88, 22)];
    textfied.backgroundColor =[UIColor whiteColor];
    if (xieyi_name.length>0) {
        textfied.text = xieyi_name;
    }else{
        textfied.text = @"http";}
    [self.view addSubview:textfied];
    textfied.inputView =pickview;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row==0) {
        return @"http";
    }
    else{
        
        return @"https";
        
    }
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (row==0) {
        textfied.text = @"http";
    }else{ textfied.text = @"https";}
    
    [textfied resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//保存服务器设置按钮
-(IBAction)serverSubmitButton:(id)sender{
    if(servetIp.text.length<8){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        // Set the annular determinate mode to show task progress.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = NSLocalizedString(@"请检查IP地址是否正确!", @"HUD message title");
        // Move to bottm center.
        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        [hud hideAnimated:YES afterDelay:2.f];
    }else{
        if (servetPort.text.length<2) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            // Set the annular determinate mode to show task progress.
            hud.mode = MBProgressHUDModeText;
            hud.label.text = NSLocalizedString(@"请检查端口是否正确!", @"HUD message title");
            // Move to bottm center.
            hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
            [hud hideAnimated:YES afterDelay:2.f];
        }else{
            NSUserDefaults *internetSetting = [NSUserDefaults standardUserDefaults];
            NSString *ipname = servetIp.text;
            NSString *portname = servetPort.text;
            NSString *xieyiname = textfied.text;//协议
            [internetSetting setObject:ipname forKey:@"server_ip"];
            [internetSetting setObject:portname forKey:@"server_port"];
            [internetSetting setObject:xieyiname forKey:@"server_xieyi"];
            [internetSetting synchronize];
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            
            // Set the custom view mode to show any view.
            hud.mode = MBProgressHUDModeCustomView;
            // Set an image view with a checkmark.
            UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            hud.customView = [[UIImageView alloc] initWithImage:image];
            // Looks a bit nicer if we make it square.
            hud.square = YES;
            // Optional label text.
            hud.label.text = NSLocalizedString(@"服务器设置成功！", @"HUD done title");
            [hud hideAnimated:YES afterDelay:1.f];
        }
        
    }
    
    
    
}

//点击返回登陆界面
-(void)backTouchevent:(id)sender
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    TbmLoginViewController *loginview = [[TbmLoginViewController alloc]init];
    [self presentViewController:loginview animated:YES completion:nil];
}
//输入字符长度设置
-(void)textFieldDidChangeip:(UITextField *)textField{
    if(servetIp.text.length>15){
        servetIp.text = [servetIp.text substringToIndex:15];
    }
    
}
-(void)textFieldDidChangePort:(UITextField *)textField{
    if(servetPort.text.length>4){
        servetPort.text = [servetPort.text substringToIndex:4];
        
    }
}
//点击背景隐藏键盘
-(void)MakeKeyboardDisappear:(id)sender
{
    [servetIp resignFirstResponder];
    [servetPort resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [servetIp resignFirstResponder];
    [servetPort resignFirstResponder];
    return YES;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
