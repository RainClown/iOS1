//
//  AppDelegate.m
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/2/29.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "AppDelegate.h"
#import "TbmLoginViewController.h"
#import "FlashLibraryViewController.h"
#import "TbmScreenViewController.h"
//主界面声明
#import "MainViewController.h"
#import "LeftSortsViewController.h"
@interface AppDelegate ()

@property(nonatomic,strong)FlashLibraryViewController *screenintroductionView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //默认是 login_yes
    /*
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     NSString *first_login = @"login_no";
     [defaults setObject:first_login forKey:@"firstlogin"];
     [defaults synchronize];
     */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    TbmLoginViewController *login = [[TbmLoginViewController alloc]init];
    TbmScreenViewController *screen = [[TbmScreenViewController alloc]init];
    
    //主界面增加
    //通知用于改变 rootController
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(switchRootVc:) name:@"SwitchRnootVCNotificatio" object:nil];
    
    
    
    
    
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    NSUserDefaults *denglu = [NSUserDefaults standardUserDefaults];
    NSString *first_login = [denglu objectForKey:@"firstlogin"];
    //初始化登陆进行验证 判断是否是第一次登陆   login_no:不是第一登陆   login_yes:是第一次登陆
    NSString  *tbmLogin = @"login_no";
    if([first_login isEqualToString:tbmLogin]){
        //如果为true  表示不是第一次登陆  直接进入 login 界面
        NSLog(@"true");
        self.window.rootViewController =login;
        [self.window makeKeyAndVisible];
        
        return YES;
        
    }else{
        //如果为false 表示 是第一次登陆  直接进入 引导页 界面
        NSLog(@"false");
        self.window.rootViewController =screen;
        [self.window makeKeyAndVisible];
        
        NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
        NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
        self.screenintroductionView = [[FlashLibraryViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
        
        [self.window addSubview:self.screenintroductionView.view];
        
        //__weak AppDelegate *weakSelf = self;
        //self.screenintroductionView.didSelectedEnter = ^() {
        //   weakSelf.screenintroductionView = nil;
        //};
        
        
        return YES;
        
        
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//left event
-(void)switchRootVc:(NSNotificationCenter *) note{
    MainViewController  *mainVC = [[MainViewController alloc]init];
    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:mainVC];
    NSLog(@"执行切换rootVC");
    self.window.rootViewController = self.LeftSlideVC;
    
}
-(void)dealloc{
   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SwitchRnootVCNotificatio" object:nil];
    
}

@end
