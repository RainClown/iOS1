//
//  textFieldBackground.m
//  IOSTopSecTBM
//
//  Created by www.topsec.com.cn on 16/3/1.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import "textFieldBackground.h"

@implementation textFieldBackground

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.2);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 5, 50);
    CGContextAddLineToPoint(context, self.frame.size.width-5, 50);
    CGContextClosePath(context);
    [[UIColor grayColor] setStroke];
    CGContextStrokePath(context);
    
}


@end
