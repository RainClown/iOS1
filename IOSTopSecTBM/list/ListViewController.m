//
//  ListViewController.m
//  IOSTopSecTBM
//
//  Created by topsec on 16/5/9.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (_listtab== nil) {
        // 表格控件在创建时必须指定样式，只能使用以下实例化方法
        CGRect fram  = CGRectMake(4, 42, self.view.frame.size.width-8, self.view.frame.size.height);
        _listtab = [[UITableView alloc] initWithFrame:fram style:UITableViewStylePlain];
        _listtab.dataSource = self;
        _listtab.delegate = self;
        //_listtab.center=self.view.center;
        _listtab.backgroundColor =[UIColor colorWithRed:230.0f/255.0f green:245.0f/255.0f blue:253.0f/255.0f alpha:1];
        
                [self.view addSubview:_listtab];
        self.listtab.rowHeight = 188;
                
    }
    // Do any additional setup after loading the view.
    //设置背景
    self.view.backgroundColor =[UIColor whiteColor];
    /*
     该部分代表 头部标签
     */
    //头部背景
    _Topbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/13)];
    _Topbg.backgroundColor = [UIColor redColor];
    [self.view addSubview:_Topbg];
    //头部title
    _Toptext = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/12)];
       [_Toptext setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    _Toptext.text = @"检查任务";
    _Toptext.textColor = [UIColor whiteColor];
    _Toptext.textAlignment = NSTextAlignmentCenter;
    [_Topbg addSubview:_Toptext];
    
    int backimage_y = ((self.view.frame.size.height/12)-(self.view.frame.size.height/16))/2;
    _backbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, backimage_y, self.view.frame.size.height/15, self.view.frame.size.height/16)];
    [_backbg setImage:[UIImage imageNamed:@"menu"]];
    [self.view addSubview:_backbg];
    _backbg.userInteractionEnabled = YES;
    //必须为YES才能响应事件
    UITapGestureRecognizer *backTouch=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTouchevent:)];
    [_backbg addGestureRecognizer:backTouch];
    
    
    //self.view.backgroundColor=[UIColor colorWithRed:239/255 green:239/255 blue:244/255 alpha:1];
    
    
    // Do any additional setup after loading the view.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return 5;





}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.定义一个cell的标识
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3.如果缓存池中没有cell
    if (!cell) {
        
        NSLog(@"加载数据");
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"list" owner:nil options:nil]lastObject];
    }
    
    //4.返回
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"我被点了");
}

-(void)backTouchevent:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
