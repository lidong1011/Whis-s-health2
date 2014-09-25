//
//  NetworkManager.h
//  HealthData
//
//  Created by apple on 14-9-15.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject


+ (NetworkManager *)sharedManager;

// 获取健康小常识
- (void)getCommonSense;

// 获取微医院
- (void)getMicroHospital;

@end
