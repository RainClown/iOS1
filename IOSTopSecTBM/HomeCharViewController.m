//
//  HomeCharViewController.m
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/3/28.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "HomeCharViewController.h"

@interface HomeCharViewController ()

@end

@implementation HomeCharViewController
@synthesize Topbg;
@synthesize Toptext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    if (_scoview == nil) {
        
        _scoview = [[UIScrollView alloc]init];
        // 表格控件在创建时必须指定样式，只能使用以下实例化方法
        //CGRect fram  = CGRectMake(0, 0, self.view.frame.size.width-6, self.view.frame.size.height-14);
        _scoview.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-46);
        _scoview.backgroundColor = [UIColor redColor];
        
        [self.view addSubview:_scoview];
        
        
    }

    
    
    if (_pacn==nil) {
        _pacn =[[UIPageControl alloc]init];
        
        
        
        
        // 设置UIPageControl的大小和位置
        _pacn.frame = CGRectMake(0
                                       , CGRectGetHeight(self.scoview.frame) - 80
                                       , CGRectGetWidth(self.scoview.frame), 80);
        // 设置UIPageControl的圆点的颜色
        _pacn.pageIndicatorTintColor = [UIColor grayColor];
        // 设置UIPageControl的高亮圆点的颜色
        _pacn.currentPageIndicatorTintColor = [UIColor yellowColor];
        // 设置UIPageControl控件当前显示第几页
     
        // 设置UIPageControl控件总共包含多少页
        _pacn.numberOfPages =3;
       _pacn.hidesForSinglePage = YES;
        // 为pageControl的Value Changed事件绑定事件处理方法
      //  [_pacn addTarget:self action:@selector(changePage:)
          //    forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_pacn];
    }
    
    
    for (int i = 0; i< 3; i ++) {
        //创建图片控件
       UIImageView *imageView = [[UIImageView alloc]init];
        UILabel *lab =[[UILabel alloc]init];
        
        //设置属性
        CGFloat imageViewX = i * self.view.frame.size.width;
        
        imageView.frame = CGRectMake(imageViewX, 0, self.view.frame.size.width, self.scoview.frame.size.height);
        lab.frame = CGRectMake(imageViewX, 0, self.view.frame.size.width, self.scoview.frame.size.height);

        //设置图片
        //img_00 01 02
        //imageView.backgroundColor = [UIColor blueColor];
        
        
        if (i==1) {
           imageView.image =[UIImage imageNamed:@"1"];
            lab.text =@"hhhh";
            
        }else{imageView.image =[UIImage imageNamed:@"2"];
        lab.text =@"kkkk";
        
        }
                //添加到对应的控件中
        [self.scoview   addSubview:imageView];
        [self.scoview   addSubview:lab];
    }
    
    //lastObject获取的是滑动条
    self.scoview.showsHorizontalScrollIndicator = NO;
    self.scoview.showsVerticalScrollIndicator = NO;
   
    //获取宽
    //CGFloat width = CGRectGetMaxX([self.scoview.subviews lastObject].frame);
    
    //设置contentSize属性
    self.scoview.contentSize = CGSizeMake(self.view.frame.size.width*3, 0);
    
    //设置分页效果
    self.scoview.pagingEnabled = YES;
    
    
    //设置pageControl的页数
    
    //1.设置代理对象
    self.scoview.delegate = self;
    
  self.pacn.currentPage = 1;
    
    self.scoview.contentOffset =CGPointMake(self.view.frame.size.width, 0);
    
    
    
    
    
    
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
    Toptext.text = @"统计汇总";
    Toptext.textColor = [UIColor whiteColor];
    Toptext.textAlignment = NSTextAlignmentCenter;
    [Topbg addSubview:Toptext];



}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    NSLog(@"滚动时调用的方法");
    //如何计算分页?
    //用当前的偏移/ UIScrollView宽 得到当前第几页
    // 让当前的偏移 + 控件宽度的一半
    //    int page = scrollView.contentOffset.x / self.scrollView.frame.size.width  ;
    
    int page = (scrollView.contentOffset.x + self.scoview.frame.size.width * 0.5 ) / self.scoview.frame.size.width;
    
    NSLog(@"%lf",scrollView.contentOffset.x);
    
    //page的页 是从0 开始
    self.pacn.currentPage = page;
    
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
