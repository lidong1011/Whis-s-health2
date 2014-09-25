//
//  HTMLManager.m
//  CaiCai
//
//  Created by apple on 14-9-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HTMLManager.h"
#import "Configuration.h"
#import "DownDataManager.h"
#import "HTMLParser.h"

@interface HTMLManager ()
{
    NSDictionary *_dataDic;
}
@end

@implementation HTMLManager
+ (HTMLManager *)shareHtmlManager
{
    static HTMLManager *shareHtml = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareHtml = [[HTMLManager alloc]init];
    });
    return shareHtml;
}

- (instancetype)init
{
    if(self=[super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jieXiHtml:) name:kDidGetData object:nil];
    }
    return self;
}


- (void)jieXiHtml:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    NSData *data = [dic objectForKey:@"data"];
    NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@===",html);
    HTMLParser *htmlParser = [[HTMLParser alloc]initWithString:html error:nil];
    NSMutableArray *_imageUrlMArray = [NSMutableArray array];
    NSMutableArray *_titleMArray = [NSMutableArray array];
    NSMutableArray *_detailUrlMArray = [NSMutableArray array];
    HTMLNode *badyNode = [htmlParser body];
    NSArray *imgNode = [badyNode findChildTags:@"ul"];
//    NSLog(@"%@",imgNode);
    for (HTMLNode *node in imgNode)
    {
        NSArray *aNode = [node findChildTags:@"img"];
        NSArray *detailUrl = [node findChildTags:@"a"];
//        NSLog(@"%d",detailUrl.count);
        for (HTMLNode *ulNode in aNode)
        {
            [_imageUrlMArray addObject:[ulNode getAttributeNamed:@"src"]];
            [_titleMArray addObject:[ulNode getAttributeNamed:@"alt"]];
        }
        for (HTMLNode *detailNode in detailUrl)
        {
            [_detailUrlMArray addObject:[detailNode getAttributeNamed:@"href"]];
        }
    }
    NSRange range = NSMakeRange(0, 2);
    [_detailUrlMArray removeObjectsInRange:range];
    NSLog(@"%@",_imageUrlMArray);
    _dataDic = [NSDictionary dictionaryWithObjectsAndKeys:_imageUrlMArray,@"imgData",_titleMArray,@"title",_detailUrlMArray,@"detail", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshCData object:nil userInfo:_dataDic];
    [[NSNotificationCenter defaultCenter] removeObserver:kDidGetData];
}

- (NSDictionary *)getData
{
    if (_dataDic==nil)
    {
        [[DownDataManager shareManager] getData];
    }
    return _dataDic;
}

@end
