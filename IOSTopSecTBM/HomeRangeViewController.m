//
//  HomeRangeViewController.m
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/3/28.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "HomeRangeViewController.h"
#import "RangCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "myrang.h"
#import "MBProgressHUD.h"
@interface HomeRangeViewController ()
@property (nonatomic,strong) NSArray  *tgArry;
@end

@implementation HomeRangeViewController
@synthesize Topbg;
@synthesize Toptext;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //主体tablview
    if (_rtableView == nil) {
        // 表格控件在创建时必须指定样式，只能使用以下实例化方法
        CGRect fram  = CGRectMake(0, 0, self.view.frame.size.width-6, self.view.frame.size.height-14);
        _rtableView = [[UITableView alloc] initWithFrame:fram style:UITableViewStylePlain];
        _rtableView.dataSource = self;
        _rtableView.delegate = self;
        _rtableView.center=self.view.center;
        _rtableView.backgroundColor =[UIColor colorWithRed:230.0f/255.0f green:245.0f/255.0f blue:253.0f/255.0f alpha:1];
        
        [self xiala];
        [self.view addSubview:_rtableView];
        
    }
    // Do any additional setup after loading the view.
    //设置背景
    self.view.backgroundColor =[UIColor whiteColor];
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
    Toptext.text = @"不合规范围TOP10";
    Toptext.textColor = [UIColor whiteColor];
    Toptext.textAlignment = NSTextAlignmentCenter;
    [Topbg addSubview:Toptext];
    
    
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 54)];
    //foot.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"repoetbg3"]];
    foot.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:245.0f/255.0f blue:253.0f/255.0f alpha:1];
    self.rtableView.tableFooterView = foot;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:245.0f/255.0f blue:253.0f/255.0f alpha:1];
    self.rtableView.rowHeight =118;
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height/12)];
    //head.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"repoetbg3"]];
    head.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:245.0f/255.0f blue:253.0f/255.0f alpha:1];
    
    
    self.rtableView.tableHeaderView = head;
    self.rtableView.separatorStyle =NO;
    
    
    
    
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
-(void)xiala{
    self.rtableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.rtableView.header beginRefreshing];
    
}


-(void)loadNewData{
    NSUserDefaults* user=[NSUserDefaults  standardUserDefaults];
    NSString* xieyi=[user objectForKey:@"server_xieyi"];//协议
    NSString* tbm_ip=[user objectForKey:@"server_ip"];//ip
    NSString* tbm_port=[user objectForKey:@"server_port"];//port
    NSString* tbm_token=[user objectForKey:@"tbm_device_token"];//token
    NSString* tbm_device=[user objectForKey:@"tbm_device_id"];//token
    
    if([xieyi isEqualToString:@"http"]){
        NSString *str = [NSString stringWithFormat:@"http://%@:%@/tbmweb/mobile/asset!modelSopeHotData.do?deviceId=%@&token=%@",tbm_ip,tbm_port,tbm_device,tbm_token];
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
              NSString *status_msg   = responseObject[@"msg"];//msg
              if([status_range isEqual:@1]){
                  NSArray * ary =  responseObject[@"data"][@"data"];
                  //   NSUserDefaults *dd= [NSUserDefaults standardUserDefaults];
                  //[dd setObject:ary forKey:@"dataary"];
                  //  [dd synchronize];
                  _tgArry =  [myrang  tgWitharry:ary];
                  [_rtableView setHidden:NO];
                  NSLog(@"%@",_tgArry);
                  [self.rtableView reloadData];
                  [self.rtableView.header endRefreshing];
              
              }else{
                  [_rtableView setHidden:YES];
                  NSLog(@"对不起没有数据％@",status_msg);
              
              }
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"==========%@",error);
          }];
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
            NSString *str = [NSString stringWithFormat:@"http://%@:%@/tbmweb/mobile/asset!modelSopeHotData.do?deviceId=%@&token=%@",tbm_ip,tbm_port,tbm_device,tbm_token];
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
                  NSString *status_msg   = responseObject[@"msg"];//msg
                  if([status_range isEqual:@1]){
                      NSArray * ary =  responseObject[@"data"][@"data"];
                      _tgArry =  [myrang  tgWitharry:ary];
                      
                      
                  }else{
                      NSLog(@"对不起没有数据％@",status_msg);
                      
                  }
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSLog(@"==========%@",error);
              }];
        }

        
    }
    return _tgArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"rcell";
    RangCell * rcell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (rcell == nil) {

        rcell = [[[NSBundle mainBundle] loadNibNamed:@"Rangcell" owner:nil options:nil] lastObject];

    }
    myrang *randa =self.tgArry[indexPath.row];
    
    rcell.data =randa;
    
    return rcell;
    
    
    
}


@end

