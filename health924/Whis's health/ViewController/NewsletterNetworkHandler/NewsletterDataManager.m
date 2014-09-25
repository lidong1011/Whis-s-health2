//
//  NewsletterDataManager.m
//  运动饮食
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import "NewsletterDataManager.h"
#import "Configuration.h"
#import "NewsletterNetworkManager.h"
#import "SportItem.h"

@interface NewsletterDataManager () {
    NSMutableArray *_newsletterData;
}

@end

@implementation NewsletterDataManager

+ (instancetype)shareManager {
    static NewsletterDataManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NewsletterDataManager alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNewsletter:) name:kGetNewsletter object:nil];
    }
    return self;
}

- (void)didNewsletter:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *html = [[NSString alloc] initWithData:[userInfo valueForKey:@"data"] encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", html);
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[userInfo valueForKey:@"data"] options:NSJSONReadingAllowFragments error:&error];
//    NSLog(@"-----------------> dict: %@", dict);
    if (error) {
        NSLog(@"parse error: %@", error);
    }
    NSArray *sportArray = dict[@"data"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *d in sportArray) {
        NSLog(@"d:%@", d);
        SportItem *item = [SportItem sportItem:d];
        [array addObject:item];
    }
    _newsletterData = array;
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshNewsletterData object:nil];
    _newsletterData = nil;
}

- (NSArray *)newsletterData {
    if (_newsletterData == nil) {
        [[NewsletterNetworkManager shareManager] getNewsletter];
    }
    return _newsletterData;
}

@end
