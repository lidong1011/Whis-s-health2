//
//  NewsletterNetworkManager.m
//  运动饮食
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import "NewsletterNetworkManager.h"
#import "AFNetworking.h"
#import "Configuration.h"

@interface NewsletterNetworkManager () {
    NSMutableString *_newsletterUrl;
}

@end


@implementation NewsletterNetworkManager

+ (NewsletterNetworkManager *)shareManager {
    static NewsletterNetworkManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NewsletterNetworkManager alloc] init];
    });
    return shareInstance;
}

- (void)getNewsletter {
    _newsletterUrl = [NSMutableString stringWithString:@"http://phone.manle.com/yaodian.php?mod=info_channel_info_list&channel_id=28&relevance=0&start=0&rows=&os=android&ver=4.2.3"];    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:_newsletterUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kGetNewsletter object:nil userInfo:@{@"data":responseObject}];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Newsletter Error: %@", error);
    }];
}

@end
