//
//  RangCell.m
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/4/28.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "RangCell.h"
#import "myrang.h"

#define DEFAULT_VOID_COLOR [UIColor clearColor]

@implementation RangCell
-(void)setData:(myrang *)data{
    _data =data;
    CircleProgressView *progress = [[CircleProgressView alloc]initWithFrame:CGRectMake(244, 33, 50, 50)];
    progress.arcFinishColor =
    [self colorWithHexString:@"#73AF36"];
    progress.arcUnfinishColor =
    [self colorWithHexString:@"#FF0000"];
    progress.arcBackColor = [self colorWithHexString:@"#EAEAEA"];
    //这里传百分比
    progress.percent = [data.SIZE floatValue];
    progress.width = 3;
    [self.contentView addSubview:progress];
    
    
    
    
    
    
    
    self.shebeilab.text =  data.MODEL_SCOPE_NAME;
    
    //int myInt = [myNumber intValue];；
    //self.jindu.percent = [data.SIZE floatValue];
    //NSLog(@"返回的数据%@",self.data.NUM);
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
   

    // Initialization code
}
- (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
