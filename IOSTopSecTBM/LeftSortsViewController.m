//
//  LeftSortsViewController.m
//  IOSTopSecTBM
//
//  Created by topsec on 16/4/11.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"liu_tab_button"];
    [self.view addSubview:imageview];
    //增加布局头部
    UIView *view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    //增加点击事件，view_head 进入账号管理界面
    UITapGestureRecognizer *head_event = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Headuser:)];
    [view_head addGestureRecognizer:head_event];
    //////////////////////////////////////////////////////////////////////////////////////
    [self.view addSubview:view_head];
    UIImageView *headImag = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 40, 40)];
    [headImag setImage:[UIImage imageNamed:@"user_change.png"]];
    [view_head addSubview:headImag];

    
    //用户名显示 top
    //获取是否存储的信息
    NSUserDefaults *ipor = [NSUserDefaults standardUserDefaults];
    NSString   *tbm_user_name = [ipor objectForKey:@"tbm_user"];
    UILabel *user_left = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, self.view.frame.size.width, 40)];
    user_left.text = tbm_user_name;
    user_left.textColor = [UIColor whiteColor];
    user_left.textAlignment = NSTextAlignmentLeft;
    [user_left setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];

    [view_head addSubview:user_left];
    //下划线
    int line_width = (self.view.frame.size.width/5)*3;
    UIImageView *headImag_line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, line_width, 2)];
    [headImag_line setImage:[UIImage imageNamed:@"top_navigation_line.png"]];
    [view_head addSubview:headImag_line];
    //设置tabview mid
    int tabview_h = (self.view.frame.size.height/5)*3;
    UIView *view_mid = [[UIView alloc]initWithFrame:CGRectMake(0, 101, self.view.frame.size.width, tabview_h)];
    [self.view addSubview:view_mid];
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;//设置是否需要分割线
    //设置行高
    tableview.rowHeight= 70;
    //取消上拉 下啦
    tableview.bounces = NO;
    tableview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"liu_tab_button"]];
    [view_mid addSubview:tableview];
    //自定义底部标签  bottom
    int tabview_h_bottom = self.view.frame.size.height/5;
    int bottom_y = 100 + tabview_h;
    UIView *view_bottom = [[UIView alloc]initWithFrame:CGRectMake(5, bottom_y, self.view.frame.size.width, tabview_h_bottom)];
    //增加点击事件，view_head 进入账号管理界面
    UITapGestureRecognizer *bottom_event = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Bottomevent:)];
    [view_bottom addGestureRecognizer:bottom_event];
    //////////////////////////////////////////////////////////////////////////////////////
    [self.view addSubview:view_bottom];
    UIImageView *bottom_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 35, 35)];
    [bottom_image setImage:[UIImage imageNamed:@"left_image_share.png"]];
    [view_bottom addSubview:bottom_image];
    
    //文字描述
    UILabel *uilabr_left_share = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, self.view.frame.size.width, 35)];
    uilabr_left_share.text = @"关　　于";
    uilabr_left_share.textColor = [UIColor whiteColor];
    uilabr_left_share.textAlignment = NSTextAlignmentLeft;
    [uilabr_left_share setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    
    [view_bottom addSubview:uilabr_left_share];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    //cell.textLabel.
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    //增加左侧图片
    UIImage *image = nil;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"首　　页";
        image = [UIImage imageNamed:@"home_left_image1"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"设备中心";
        image = [UIImage imageNamed:@"home_left_image2"];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"检查任务";
        image = [UIImage imageNamed:@"home_left_image3"];
    }
    cell.imageView.image = image;
    //设置被选中的嘶吼颜色不变
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
       
    } else if (indexPath.row == 2) {
      
        
     ListViewController  *lViewController = [[ListViewController  alloc]init];
        [self presentViewController:lViewController animated:YES completion:nil];

        
        
    }

  

    
    
    
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //[tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//底部
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{

    return  30;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, 10)];
    bottom.backgroundColor = [UIColor clearColor];
    UIImageView *headImag = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 40, 40)];
    [headImag setImage:[UIImage imageNamed:@"user_change.png"]];
    return bottom;
}
//进入账号管理界面
-(void)Headuser:(id)sender{
    NSLog(@"账号管理界面");
    UserInformationViewController *userViewController = [[UserInformationViewController alloc]init];
    [self presentViewController:userViewController animated:YES completion:nil];

}
//进入关于界面
-(void)Bottomevent:(id)sender{
    NSLog(@"关于界面");
    AboutViewController *aboutViewController = [[AboutViewController alloc]init];
    [self presentViewController:aboutViewController animated:YES completion:nil];
    
    
    /*
    AboutViewController *aboutViewController = [[AboutViewController alloc]init];
    aboutViewController.title = @"关　　于";
    
    self.navController = [[UINavigationController alloc] init];
    
    self.navController.navigationBar.barTintColor = [UIColor redColor];
    self.navController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    ////////////////////
    [self.navController pushViewController:aboutViewController animated:YES];
    [self.view.window addSubview:self.navController.view];
    */
    
}

@end