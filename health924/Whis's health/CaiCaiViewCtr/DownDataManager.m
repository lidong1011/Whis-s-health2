//
//  DownDataManager.m
//  CaiCai
//
//  Created by apple on 14-9-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//
#import "FMDatabase.h"
#import "DownDataManager.h"
#import "Configuration.h"
#import "AFNetworking.h"
#import "HTMLManager.h"
@interface DownDataManager()
{
    NSMutableString *_getDataUrl;
    NSString *_path;
    FMDatabase *_CaiCaiDBData;
}
@end

@implementation DownDataManager

+ (instancetype)shareManager
{
    static DownDataManager *downData= nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        downData = [[DownDataManager alloc]init];
    });
    return downData;
}

- (void)getData
{
    _getDataUrl = [NSMutableString stringWithFormat:@"%@",@"http://cs.15.cc/caicai/"];
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:_getDataUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//        [[NSNotificationCenter defaultCenter] postNotificationName:kDidGetData object:nil];
        [self creatDBData:responseObject];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)creatDBData:(id)responder
{
    _path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CaiCaiData.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    _CaiCaiDBData = [FMDatabase databaseWithPath:_path];
    if ([fileManager fileExistsAtPath:_path] == NO)
    {
        //creat 数据表
        if([_CaiCaiDBData open])
        {
            NSString *sql = @"CREATE TABLE CaiCaiData(hid integer primary key autoincrement not null,indentifiers integer unique,caiData blob)";
            BOOL res = [_CaiCaiDBData executeUpdate:sql];
            if (!res)
            {
                NSLog(@"error when creating table");
        
            }
            else
            {
                NSLog(@"creating succ");
                [self insertData:responder];
                [_CaiCaiDBData close];
            }
        }
        else
        {
            NSLog(@"open fail");
        }
    }
    else
    {
        if ([_CaiCaiDBData open])
        {
            [self insertData:responder];
            [_CaiCaiDBData close];
        }
    }
}

- (void)insertData:(id)responseObject
{
    NSString *sql = @"insert or replace into CaiCaiData(indentifiers, CaiData) values(?, ?)";
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseObject];
    static int i = 0;
    BOOL res = [_CaiCaiDBData executeUpdate:sql,i,data];
    if (!res)
    {
        NSLog(@"error to insert data");
    }
    else
    {
        NSLog(@"succ to insert data");
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidGetData object:nil userInfo:@{@"data":responseObject}];
    }
}




@end
