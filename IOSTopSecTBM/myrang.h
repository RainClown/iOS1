//
//  myrang.h
//  IOSTopSecTBM
//
//  Created by topsec on 16/4/25.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface myrang : NSObject


@property(nonatomic,copy) NSString * MODEL_SCOPE_NAME;
@property(nonatomic ,strong)NSNumber * NUM;
@property (nonatomic ,strong)NSNumber * SIZE;

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
