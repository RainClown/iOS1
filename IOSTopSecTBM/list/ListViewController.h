//
//  ListViewController.h
//  IOSTopSecTBM
//
//  Created by topsec on 16/5/9.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,strong) UITableView *listtab;
@property(nonatomic,strong)UIImageView      *Topbg;//1/13
@property(nonatomic,strong)UILabel          *Toptext;
@property(nonatomic,strong)UIImageView      *backbg;
@end
