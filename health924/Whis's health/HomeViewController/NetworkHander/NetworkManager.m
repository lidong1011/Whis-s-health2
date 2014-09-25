//
//  NetworkManager.m
//  HealthData
//
//  Created by apple on 14-9-15.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import "NetworkManager.h"

#import "AFNetworking.h"

#import "Configuration.h"

#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface NetworkManager () {
    NSMutableString *_getCommonSenseUrl;
    NSString *_dbPath;
    FMDatabase *_db;

}

@end

static int _number = 0;

@implementation NetworkManager


+ (NetworkManager *)sharedManager {
    static NetworkManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NetworkManager alloc] init];
    });
    return shareInstance;
}

// 获取健康小常识的数据
- (void)getCommonSense {
    _getCommonSenseUrl = [NSMutableString stringWithFormat:@"http://cs.15.cc/welcome/list_more/%ld/3", (long)_number];
    _number++;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:_getCommonSenseUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self postNotification:responseObject];
        // 数据库处理
        if (_number > 1) {
            [self commendSencePostNotification:responseObject];
        } else {
            [self databaseHandler:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Common Sence Error: %@", error);
    }];
}
// 获取微医院的数据
- (void)getMicroHospital {
    AFHTTPRequestOperationManager *hospitalManager = [AFHTTPRequestOperationManager manager];
    
    
    hospitalManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [hospitalManager GET:@"http://yy.15.cc/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //下载完成后发送通知将数据传递出去
        [[NSNotificationCenter defaultCenter] postNotificationName:kGetMicroHospital object:nil userInfo:@{@"data":responseObject}];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Micro Hospital Error: %@", error);
    }];
}

- (void)databaseHandler:(id)responseObject {
    // 创建表
    [self createTable:responseObject];
}

- (void)createTable:(id)responseObject {
    _dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/healthData.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    _db= [FMDatabase databaseWithPath:_dbPath];
    if ([fileManager fileExistsAtPath:_dbPath] == NO ) {
        // create it

        if ([_db open]) {
            NSString *sql = @"CREATE TABLE healthData (hid integer primary key autoincrement not null, indentifiers integer unique, healthData blob)";
            BOOL res = [_db executeUpdate:sql];
            if (!res) {
                NSLog(@"error when creating db table");
            } else {
                NSLog(@"succ to creating db table");
                // 插入数据
                [self insertData:responseObject];
            }
            [_db close];
        } else {
            NSLog(@"error when open db");
        }
    } else {
        if ([_db open]) {
            // 插入数据
            [self insertData:responseObject];
            [_db close];
        }
    }
}

- (void)insertData:(id)responseObject {
    NSString *sql = @"insert or replace into healthData (indentifiers, healthData) values(?, ?)";
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:responseObject];
    static int i = 0;
    BOOL res = [_db executeUpdate:sql, i, data];
    if (!res) {
        NSLog(@"error to insert data");
    } else {
        NSLog(@"succ to insert data");
        // 发通知
        [self commendSencePostNotification:responseObject];
    }
    i++;
}

- (void)commendSencePostNotification:(id)responseObject {
    //下载完成后发送通知将数据传递出去
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetCommendSence object:nil userInfo:@{@"data":responseObject}];
}


@end
