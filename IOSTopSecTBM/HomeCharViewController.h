//
//  HomeCharViewController.h
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/3/28.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCharViewController : UIViewController<UIScrollViewDelegate  >
@property(nonatomic,strong)UIImageView      *Topbg;//1/13
@property(nonatomic,strong)UILabel          *Toptext;
@property (nonatomic ,strong)UIScrollView  *scoview;
@property (nonatomic,strong) UIPageControl * pacn;
@end
