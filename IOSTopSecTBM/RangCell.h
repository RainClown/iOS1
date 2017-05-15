//
//  RangCell.h
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/4/28.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
@class myrang;
@interface RangCell : UITableViewCell

@property (strong ,nonatomic ) CircleProgressView *jindu;
@property (strong ,nonatomic)  myrang * data;
@property (strong, nonatomic) IBOutlet UILabel *shebeilab;
@end
