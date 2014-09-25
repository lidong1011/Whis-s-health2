//
//  sportItem.m
//  运动饮食
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import "SportItem.h"

@implementation SportItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        [self setValue:dict[@"title"] forKey:@"title"];
        [self setValue:dict[@"img"] forKey:@"img"];
        [self setValue:dict[@"contents"] forKey:@"contents"];
        [self setValue:dict[@"url"] forKey:@"url"];
        [self setValue:dict[@"like_count"] forKey:@"like_count"];
    }
    return self;
}

+ (instancetype)sportItem:(NSDictionary *)dict {
    return [[SportItem alloc] initWithDict:dict];
}

@end
