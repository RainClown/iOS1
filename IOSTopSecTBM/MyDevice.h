//
//  MyDevice.h
//  IOSTopSecTBM
//
//  Created by 土豆vs7 on 16/5/3.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDevice : NSObject
//反馈数据
@property(nonatomic,strong) NSNumber * ASSET_TYPE;//设备类型
@property(nonatomic,strong) NSString * ASSET_IP;//设备IP
@property(nonatomic,strong) NSNumber * SCORE;//得分
@property(nonatomic,strong) NSString * TARGET_END_DATE;//扫描时间
@property(nonatomic,strong) NSNumber * SCAN_LEVEL;//安全级别 0安全 1高危 2中危 3低危
@property(nonatomic,strong) NSNumber * ASSET_NAME;//设备名称
-(instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  初始化当前模型对象的类方法
 *
 *  @param dict 传入一个字典数据
 *
 *  @return 返回当前模型对象
 */
+ (instancetype)tgWithDict:(NSDictionary *)dict;


+ (NSArray *)tgWitharry:(NSArray *)myarry;



@end
