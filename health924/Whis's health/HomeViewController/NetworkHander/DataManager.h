//
//  DataManager.h
//  HealthData
//
//  Created by apple on 14-9-15.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (instancetype)sharedManager;
- (NSArray *)commendSenceData;
- (NSArray *)mircoHospital;
@end
