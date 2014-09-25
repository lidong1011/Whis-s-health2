//
//  DownDataManager.h
//  CaiCai
//
//  Created by apple on 14-9-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownDataManager : NSObject
+ (instancetype)shareManager;
- (void)getData;
@end
