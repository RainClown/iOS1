//
//  MainViewController.m
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/3/28.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
@interface MainViewController ()

@end

@implementation MainViewController

@synthesize backbg;

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     该部分代表 头部标签
     */
    //头部返回图标
    int backimage_y = ((self.view.frame.size.height/12)/2-(self.view.frame.size.height/22)/2);
    backbg = [[UIImageView alloc] initWithFrame:CGRectMake(backimage_y, backimage_y, self.view.frame.size.height/19, self.view.frame.size.height/20)];
    [backbg setImage:[UIImage imageNamed:@"menu"]];
    [self.view addSubview:backbg];
    backbg.userInteractionEnabled = YES;
    //必须为YES才能响应事件
    UITapGestureRecognizer *backTouch=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTouchevent:)];
    [backbg addGestureRecognizer:backTouch];

    
    // Do any additional setup after loading the view.
    HomeCharViewController *homeChar = [[HomeCharViewController alloc]init];//图表
    homeChar.tabBarItem.title=@"图表统计";
    homeChar.tabBarItem.image= [[UIImage imageNamed:@"ic_main_tab_match.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homeChar.tabBarItem setSelectedImage:[[UIImage imageNamed:@"ic_main_tab_match_p.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //设置内容颜色
    [homeChar.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    //设置图片及文字间隔
    homeChar.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    
    
    
    
    HomeRangeViewController *homerange = [[HomeRangeViewController alloc] init];
    homerange.tabBarItem.title=@"不合规范围";
    homerange.tabBarItem.image= [[UIImage imageNamed:@"ic_main_tab_special.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homerange.tabBarItem setSelectedImage:[[UIImage imageNamed:@"ic_main_tab_special_p.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
    //设置内容颜色
    [homerange.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    //设置图片及文字间隔
    homerange.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    
    
    HomeDeviceViewController *homedevice = [[HomeDeviceViewController alloc] init];
    homedevice.tabBarItem.title=@"不合规设备";
    homedevice.tabBarItem.image= [[UIImage imageNamed:@"ic_main_tab_team.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homedevice.tabBarItem setSelectedImage:[[UIImage imageNamed:@"ic_main_tab_team_p.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [homedevice.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    //设置图片及文字间隔
    homedevice.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    
    
    
    //设置默认和选中的背景颜色
    //[self.tabBar setBackgroundImage:[[UIImage imageNamed:@"liu_tab_button.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //[self.tabBar setSelectionIndicatorImage:[[UIImage imageNamed:@"liu_tab_button_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,49)];
    [bgImgView setImage:[UIImage imageNamed:@"liu_tab_button.png"]];
    [backView addSubview:bgImgView];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    //设置选中图片背景
    [self.tabBar setSelectionIndicatorImage:[[UIImage imageNamed:@"liu_tab_button_pres.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [self addChildViewController:homeChar];
    [self addChildViewController:homerange];
    [self addChildViewController:homedevice];
    
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
//进入侧边栏
- (void) leftTouchevent:(id)sender{
    NSLog(@"Helvetica-dasdasdasdasdasd");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchRnootVCNotificatio" object:nil];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        NSLog(@"Helvetica-open");
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        NSLog(@"Helvetica-close");
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}
@end
