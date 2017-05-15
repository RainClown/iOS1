//
//  FlashLibraryViewController.h
//  IOSTopSecTBM
//  基线管理系统
//  Created by topsec.com.cn on 16/3/4.
//  Copyright © 2016年 Topsec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectedEnter)();

@interface FlashLibraryViewController : UIViewController

@property (nonatomic, strong) UIScrollView *pagingScrollView;
@property (nonatomic, strong) UIButton *enterButton;

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;

/**
 @[@"image1", @"image2"]
 */
@property (nonatomic, strong) NSArray *backgroundImageNames;

/**
 @[@"coverImage1", @"coverImage2"]
 */
@property (nonatomic, strong) NSArray *coverImageNames;

- (id)initWithCoverImageNames:(NSArray*)coverNames;

- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames;

- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button;

@end

