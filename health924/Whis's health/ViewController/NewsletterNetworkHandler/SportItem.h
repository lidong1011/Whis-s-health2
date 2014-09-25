//
//  sportItem.h
//  运动饮食
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SportItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *contents;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) int like_count;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)sportItem:(NSDictionary *)dict;

@end
