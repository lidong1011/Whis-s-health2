//
//  MicroHospitalHandler.h
//  MicroHospital
//
//  Created by apple on 14-9-17.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "MicroHospitalCell.h"

@class  MicroHospitalHandler;

@protocol MicroHospitalHandlerDataSource <NSObject>

@required
// 格子的个数
- (NSInteger)numberOFViewInMicroHospital:(MicroHospitalHandler *)MicroHospital;
// 每个格子显示的内容
- (MicroHospitalCell *)microHospital:(MicroHospitalHandler *)microHospital cellAtIndex:(NSInteger)index;

@optional
// 一行格子的高度
- (CGFloat)microHospital:(MicroHospitalHandler *)microHospital cellHeigthAtIndex:(NSInteger)index;
@end

@protocol MicroHospitalHandlerDelegate <NSObject>

@optional
// 选中了哪个视图
- (void)microHospital:(MicroHospitalHandler *)microHospital didSelectedIndex:(NSInteger)index;

@end


@interface MicroHospitalHandler : UIView
@property (nonatomic, assign)NSInteger numberOfColumns;
@property (nonatomic, weak) id<MicroHospitalHandlerDataSource>dataSource;
@property (nonatomic, weak) id<MicroHospitalHandlerDelegate>delegate;

@property (nonatomic, assign) UIEdgeInsets edgeInset;
@property (nonatomic, assign) CGFloat spacing;

- (void)reloadData;

@end
