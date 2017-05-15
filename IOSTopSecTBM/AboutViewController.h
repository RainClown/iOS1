//
//  AboutViewController.h
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/4/19.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController{
  //定义主体内容 应用名称  应用版本
    UILabel  *appName;
    UILabel  *appVersion;
    UILabel  *appPhone;
}
@property(nonatomic,strong)UIImageView      *Topbg;//1/9
@property(nonatomic,strong)UIImageView      *backbg;
@property(nonatomic,strong)UILabel          *Toptext;

@property(nonatomic,retain)IBOutlet UILabel *appName;
@property(nonatomic,retain)IBOutlet UILabel *appVersion;
@property(nonatomic,retain)IBOutlet UILabel *appPhone;
@end
