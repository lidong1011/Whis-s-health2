//
//  NewsletterDataManager.h
//  运动饮食
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsletterDataManager : NSObject

+ (instancetype)shareManager;

- (NSArray *)newsletterData;

@end
