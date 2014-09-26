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
#import "LunBoItem.h"

@interface NewsletterDataManager ()
{
    NSMutableArray *_newsletterData;
    NSMutableArray *_lunBoMArray;
    NSMutableArray *_lunBoMArray2;
    NSMutableArray *_lunBoMArray3;
    NSMutableArray *_lunBoMArray4;
    NSInteger _index;
}

@end
//static int flog =0;
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLunBo:) name:kGetLunBoData object:nil];
    }
    return self;
}

- (void)didLunBo:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
//    NSString *html = [[NSString alloc] initWithData:[dic valueForKey:@"data"] encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",html);
//    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:[dic objectForKey:@"data"] options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"%@",dataDic);

    NSMutableArray *lunBoMArray = [NSMutableArray array];
    for (NSDictionary *d in dataDic[@"data"][@"channel_info_img"])
    {
        NSLog(@"%@",d);
        LunBoItem *lunBo = [LunBoItem lunBoItem:d];
        [lunBoMArray addObject:lunBo];
    }
    switch (_index)
    {
        case 0:
            _lunBoMArray = lunBoMArray;
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshNewsletterData object:nil];
            _lunBoMArray = nil;
            break;
        case 1:
            _lunBoMArray2 = lunBoMArray;
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshNewsletterData object:nil];
            _lunBoMArray2 = nil;
            break;
        case 2:
            _lunBoMArray3 = lunBoMArray;
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshNewsletterData object:nil];
            _lunBoMArray3 = nil;
            break;
        case 3:
            _lunBoMArray3 = lunBoMArray;
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshNewsletterData object:nil];
            _lunBoMArray3 = nil;
            break;
        default:
            break;
    }
//    if (_index == 0) {
//        _lunBoMArray = lunBoMArray;
//        [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshNewsletterData object:nil];
//        _lunBoMArray = nil;
//    }
//    else
//    {
//        _lunBoMArray2 = lunBoMArray;
//        [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshNewsletterData object:nil];
//        _lunBoMArray2 = nil;
//    }
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

- (NSArray *)lunBoDataWithString:(NSString *)string index:(NSInteger)index
{
    _index = index;
    switch (_index)
    {
        case 0:
            if (_lunBoMArray == nil)
            {
                [[NewsletterNetworkManager shareManager] getLunBodataWithString:string];
            }
            return _lunBoMArray;
            break;
        case 1:
            if (_lunBoMArray2 == nil)
            {
                [[NewsletterNetworkManager shareManager] getLunBodataWithString:string];
            }
            return _lunBoMArray2;
            break;
        case 2:
            if (_lunBoMArray3 == nil)
            {
                [[NewsletterNetworkManager shareManager] getLunBodataWithString:string];
            }
            return _lunBoMArray3;
            break;
        case 3:
            if (_lunBoMArray4 == nil)
            {
                [[NewsletterNetworkManager shareManager] getLunBodataWithString:string];
            }
            return _lunBoMArray4;
            break;
  
        default:
            return _lunBoMArray;
            break;
    }
//    if (_index ==0)
//    {
//        if (_lunBoMArray == nil)
//        {
//            [[NewsletterNetworkManager shareManager] getLunBodataWithString:string];
//        }
//        //    [[NewsletterNetworkManager shareManager] getLunBodataWithString:string];
//        return _lunBoMArray;
//    }
//    else
//    {
//    if (_lunBoMArray2 == nil)
//    {
//        [[NewsletterNetworkManager shareManager] getLunBodataWithString:string];
//    }
////    [[NewsletterNetworkManager shareManager] getLunBodataWithString:string];
//    return _lunBoMArray2;
//    }
}

- (NSArray *)newsletterData
{
    if (_newsletterData == nil)
    {
        [[NewsletterNetworkManager shareManager] getNewsletter];
    }
    return _newsletterData;
}

- (NSArray *)newsletterData:(NSString *)string index:(NSInteger)index
{
    if (_newsletterData == nil)
    {
        [[NewsletterNetworkManager shareManager] getNewsletter:string];
    }
    return _newsletterData;
}


@end
