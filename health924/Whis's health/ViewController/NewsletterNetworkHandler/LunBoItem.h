//
//  LunBoItem.h
//  What's health
//
//  Created by apple on 14-9-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LunBoItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *url;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)lunBoItem:(NSDictionary *)dic;
@end
