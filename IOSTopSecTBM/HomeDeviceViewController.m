//
//  HomeDeviceViewController.m
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/3/28.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "HomeDeviceViewController.h"
#import "DeviceCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MyDevice.h"
#import "MBProgressHUD.h"
@interface HomeDeviceViewController ()
@property (nonatomic,strong) NSArray  *tgArry;

@end

@implementation HomeDeviceViewController
@synthesize Topbg;
@synthesize Toptext;



-(UITableView *)tableView{
    //主体tablview
    if (_tableView == nil) {
        // 表格控件在创建时必须指定样式，只能使用以下实例化方法
        CGRect fram  = CGRectMake(0, 0, self.view.frame.size.width-6, self.view.frame.size.height-14);
        _tableView = [[UITableView alloc] initWithFrame:fram style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.center=self.view.center;
        _tableView.backgroundColor =[UIColor colorWithRed:230.0f/255.0f green:245.0f/255.0f blue:253.0f/255.0f alpha:1];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tgArry==nil) {
        NSUserDefaults* user=[NSUserDefaults  standardUserDefaults];
        NSString* xieyi=[user objectForKey:@"server_xieyi"];//协议
        NSString* tbm_ip=[user objectForKey:@"server_ip"];//ip
        NSString* tbm_port=[user objectForKey:@"server_port"];//port
        NSString* tbm_token=[user objectForKey:@"tbm_device_token"];//token
        NSString* tbm_device=[user objectForKey:@"tbm_device_id"];//token
        
        if([xieyi isEqualToString:@"http"]){
            NSString *str = [NSString stringWithFormat:@"http://%@:%@/tbmweb/mobile/asset!lowScoreTop20.do?deviceId=%@&token=%@",tbm_ip,tbm_port,tbm_device,tbm_token];
            NSLog(@"%@",str);
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //AFN 2.5.4
            /**
             manager.securityPolicy.allowInvalidCertificates = YES;
             **/
            //AFN 2.6.1 包括现在的3.0.4,里面它实现了代理,信任服务器
            manager.securityPolicy.validatesDomainName = NO;
            [manager GET:str
              parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  //反序列化成字符串
                  // NSMutableArray *arry =[NSArray arrayWithArray:responseObject[@""]
                  NSNumber *status_range = responseObject[@"status"];//状态
                  NSLog(@"%@",status_range);
                  NSString *status_msg   = responseObject[@"msg"];//msg
                  NSLog(@"%@",status_msg);
                  if([status_range isEqual:@1]){
                      NSArray * ary =  responseObject[@"data"];
                      _tgArry =  [MyDevice  tgWitharry:ary];
                      
                      
                  }else{
                      [_tableView setHidden:YES];
                      NSLog(@"对不起没有数据％@",status_msg);
                      
                  }
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  [_tableView setHidden:YES];
                  NSLog(@"==========%@",error);
              }];
            
            
        }
        
        
    }
    return _tgArry.count;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    self.view.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:245.0f/255.0f blue:253.0f/255.0f alpha:1];
    self.tableView.rowHeight =118;
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height/12)];
    //head.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"repoetbg3"]];
    head.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:245.0f/255.0f blue:253.0f/255.0f alpha:1];
    
    
    
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 54)];
    //foot.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"repoetbg3"]];
    foot.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:245.0f/255.0f blue:253.0f/255.0f alpha:1];
    self.tableView.tableFooterView = foot;
    self.tableView.tableHeaderView = head;
    self.tableView.separatorStyle =NO;
    // Do any additional setup after loading the view.
    
    /*
     该部分代表 头部标签
     */
    //头部背景
    Topbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/13)];
    Topbg.backgroundColor = [UIColor redColor];
    [self.view addSubview:Topbg];
    //头部title
    Toptext = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/12)];
    //Toptext.text= @"统计汇总";
    //字体加粗
    [Toptext setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    Toptext.text = @"得分最低的设备TOP20";
    Toptext.textColor = [UIColor whiteColor];
    Toptext.textAlignment = NSTextAlignmentCenter;
    [Topbg addSubview:Toptext];
    
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.tableView.header beginRefreshing];


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


-(void)loadNewData{
    NSUserDefaults* user=[NSUserDefaults  standardUserDefaults];
    NSString* xieyi=[user objectForKey:@"server_xieyi"];//协议
    NSString* tbm_ip=[user objectForKey:@"server_ip"];//ip
    NSString* tbm_port=[user objectForKey:@"server_port"];//port
    NSString* tbm_token=[user objectForKey:@"tbm_device_token"];//token
    NSString* tbm_device=[user objectForKey:@"tbm_device_id"];//token
    
    if([xieyi isEqualToString:@"http"]){
        NSString *str = [NSString stringWithFormat:@"http://%@:%@/tbmweb/mobile/asset!lowScoreTop20.do?deviceId=%@&token=%@",tbm_ip,tbm_port,tbm_device,tbm_token];
        NSLog(@"%@",str);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //AFN 2.5.4
        /**
         manager.securityPolicy.allowInvalidCertificates = YES;
         **/
        //AFN 2.6.1 包括现在的3.0.4,里面它实现了代理,信任服务器
        manager.securityPolicy.validatesDomainName = NO;
        [manager GET:str
          parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              //反序列化成字符串
              // NSMutableArray *arry =[NSArray arrayWithArray:responseObject[@""]
              NSNumber *status_range = responseObject[@"status"];//状态
               NSLog(@"%@",status_range);
              NSString *status_msg   = responseObject[@"msg"];//msg
               NSLog(@"%@",status_msg);
              if([status_range isEqual:@1]){
                  NSArray * ary =  responseObject[@"data"];
                  _tgArry =  [MyDevice  tgWitharry:ary];
                  [_tableView setHidden:NO];
                  NSLog(@"%@",ary);
              }else{
                  [_tableView setHidden:YES];
                  NSLog(@"对不起没有数据％@",status_msg);
                  
              }
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [_tableView setHidden:YES];
              NSLog(@"==========%@",error);
          }];
        
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];

    }
    
    
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"dcell_top";
    DeviceCell * dcell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (dcell == nil) {
        
        dcell = [[[NSBundle mainBundle] loadNibNamed:@"DeviceCell" owner:nil options:nil] lastObject];
        
    }
    MyDevice *danda =self.tgArry[indexPath.row];
    
    dcell.data = danda;
    
    return dcell;
    
    
    
}


@end

