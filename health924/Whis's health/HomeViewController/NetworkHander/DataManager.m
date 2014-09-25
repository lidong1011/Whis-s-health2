//
//  DataManager.m
//  HealthData
//
//  Created by apple on 14-9-15.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import "DataManager.h"
#import "Configuration.h"
#import "HTMLParser.h"
#import "HTMLNode.h"
#import "NetworkManager.h"

@interface DataManager () {
    NSMutableArray *_CommendSenceData;
    NSMutableArray *_mircoHospitalData;
}

@end

@implementation DataManager

+ (instancetype)sharedManager {
    static DataManager *shareInstance = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        shareInstance = [[DataManager alloc] init];
    });
    return shareInstance;
}

- (id)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetCommendSence:) name:kGetCommendSence object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetMicroHospital:) name:kGetMicroHospital object:nil];
    }
    return self;
}

- (void)didGetCommendSence:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *html = [[NSString alloc] initWithData:[userInfo objectForKey:@"data"] encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    if (error) {
        NSLog(@"error:%@", error);
        return;
    }
    HTMLNode *bodyNode = [parser body];
    NSArray *td = [bodyNode findChildTags:@"td"];
    NSArray *imgNode = [bodyNode findChildTags:@"img"];
    NSArray *link = [bodyNode findChildTags:@"a"];
    
    NSMutableArray *h2Value = [NSMutableArray array];
    NSMutableArray *pValue = [NSMutableArray array];
    NSMutableArray *spanValue = [NSMutableArray array];
    NSMutableArray *imgValue = [NSMutableArray array];
    NSMutableArray *linkValue = [NSMutableArray array];
    
    for (HTMLNode *t in td) {
        if ( [[t getAttributeNamed:@"class"] isEqualToString:@"list_txt"]) {
            HTMLNode *h2 = [t findChildTag:@"h2"];
            [h2Value addObject:[h2 contents] ];
            HTMLNode *p = [t findChildTag:@"p"];
            [pValue addObject:[p contents]];
            HTMLNode *h3 = [t findChildTag:@"h3"];
            HTMLNode *span = [h3 findChildTag:@"span"];
            [spanValue addObject:[span contents]];
        }
    }
    for (HTMLNode *img in imgNode) {
        [imgValue addObject:[img getAttributeNamed:@"src"]];
    }
    for (HTMLNode *l in link) {
        [linkValue addObject:[l getAttributeNamed:@"href"]];
    }
    
    
    NSMutableDictionary *dictH2 = [NSMutableDictionary dictionary];
    [dictH2 setValue:h2Value forKey:@"h2"];
    //    NSLog(@"h2:%@", [dictH2 valueForKey:@"h2"]);
    NSMutableDictionary *dictP = [NSMutableDictionary dictionary];
    [dictP setValue:pValue forKey:@"p"];
    //    NSLog(@"p:%@", [dictP valueForKey:@"p"]);
    NSMutableDictionary *dictSpan = [NSMutableDictionary dictionary];
    [dictSpan setValue:spanValue forKey:@"span"];
    //    NSLog(@"span:%@", [dictSpan valueForKey:@"span"]);
    NSMutableDictionary *dictImg = [NSMutableDictionary dictionary];
    [dictImg setValue:imgValue forKey:@"img"];
    //    NSLog(@"img:%@", [dictImg valueForKey:@"img"]);
    NSMutableDictionary *dictLink = [NSMutableDictionary dictionary];
    [dictLink setValue:linkValue forKey:@"href"];
    //    NSLog(@"link:%@", [dictLink valueForKey:@"href"]);
    
    _CommendSenceData = [NSMutableArray arrayWithObjects:dictH2, dictP, dictSpan, dictImg, dictLink, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshData object:nil];
    
    _CommendSenceData = nil;
}

- (void)didGetMicroHospital:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
//    NSLog(@"%@", userInfo);
    NSString *html = [[NSString alloc] initWithData:[userInfo objectForKey:@"data"] encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    if (error) {
        NSLog(@"error:%@", error);
        return;
    }
    HTMLNode *bodyNode = [parser body];
    
    NSArray *a = [bodyNode findChildTags:@"a"];
    NSArray *img = [bodyNode findChildTags:@"img"];
    NSArray *span = [bodyNode findChildTags:@"span"];
    
    NSMutableArray *href = [NSMutableArray array];
    NSMutableArray *src = [NSMutableArray array];
    NSMutableArray *name = [NSMutableArray array];
    
    for (HTMLNode *a1 in a) {
        NSString *str = [a1 getAttributeNamed:@"href"];
        if (str) {
            [href addObject:str];
            
        }
    }
    NSRange range = NSMakeRange(0, 10);
    [href removeObjectsInRange:range];
//    NSLog(@"href : %@ length : %ld", href, href.count);
    
    for (HTMLNode *img1 in img) {
        [src addObject:[img1 getAttributeNamed:@"src"]];
    }
    NSRange range2 = NSMakeRange(0, 8);
    [src removeObjectsInRange:range2];
//    NSLog(@"scr : %@ length : %ld", src, src.count);
    
    for (HTMLNode *span1 in span) {
        NSString *str =[span1 contents];
        if (str) {
            [name addObject: str];
        }
    }
#warning 这里记得做判断，当链接请求返回的不是正确的网页时，删除一个范围的数组会出错
    NSRange range3 = NSMakeRange(0, 8);
    [name removeObjectsInRange:range3];
//    NSLog(@"span : %@ length : %ld", name, name.count);
    
    NSMutableDictionary *dictHref = [NSMutableDictionary dictionaryWithObject:href forKey:@"href"];
    NSMutableDictionary *dictSrc = [NSMutableDictionary dictionaryWithObject:src forKey:@"src"];
    NSMutableDictionary *dictName = [NSMutableDictionary dictionaryWithObject:name forKey:@"name"];
    
    _mircoHospitalData = [NSMutableArray arrayWithObjects:dictHref, dictSrc, dictName, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshData2 object:nil];
}

- (NSArray *)commendSenceData {
    if (_CommendSenceData==nil) {
        [[NetworkManager sharedManager] getCommonSense];
    }
    return _CommendSenceData;
}

- (NSArray *)mircoHospital {
    if (_mircoHospitalData==nil) {
        [[NetworkManager sharedManager] getMicroHospital];
    }
    return _mircoHospitalData;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
