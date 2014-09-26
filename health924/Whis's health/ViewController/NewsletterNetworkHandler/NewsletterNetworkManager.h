//
//  NewsletterNetworkManager.h
//  运动饮食
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsletterNetworkManager : NSObject

+ (NewsletterNetworkManager *)shareManager;

- (void)getLunBodataWithString:(NSString *)string;
- (void)getNewsletter;
- (void)getNewsletter:(NSString *)string;
@end
