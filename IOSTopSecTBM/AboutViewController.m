//
//  AboutViewController.m
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/4/19.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize Topbg;
@synthesize backbg;
@synthesize Toptext;

@synthesize appName;
@synthesize appVersion;
@synthesize appPhone;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:245.0/255.0 blue:253.0/255.0 alpha:100];
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
    Toptext.text= @"关　　于";
    Toptext.textColor = [UIColor whiteColor];
    [Toptext setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    Toptext.textAlignment = NSTextAlignmentCenter;
    [Topbg addSubview:Toptext];

   
    //主界面内容
    NSString *version = [[[NSBundle mainBundle] infoDictionary]objectForKey:(NSString *)kCFBundleVersionKey];
    appVersion.text = version;
    //增加打电话功能
    appPhone.userInteractionEnabled = YES;
    UITapGestureRecognizer *lablePhone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lablePhoneevent:)];
    [appPhone addGestureRecognizer:lablePhone];
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
//打电话事件
-(void)lablePhoneevent:(UITapGestureRecognizer *) recognizer{
    NSString *phoneNumber = appPhone.text;
    NSMutableString *strphone = [[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest  requestWithURL:[NSURL URLWithString:strphone]]];
    [self.view addSubview:callWebview];
    
    
    
};

@end
