//
//  LunBoItem.m
//  What's health
//
//  Created by apple on 14-9-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LunBoItem.h"

@implementation LunBoItem
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self=[super init])
    {
        [self setValue:dic[@"infoTitle"] forKey:@"title"];
        [self setValue:dic[@"info_img"] forKey:@"img"];
//        [self setValue:dic[@"url"] forKey:@"url"];
    }
    return self;
}

+ (instancetype)lunBoItem:(NSDictionary *)dic
{
    return [[LunBoItem alloc]initWithDic:dic];
}
@end
