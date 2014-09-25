//
//  Detail1ViewController.m
//  Whis's health
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Detail1ViewController.h"
#import "AFNetworking.h"

typedef void(^DidHTMLHander)(Detail1ViewController *detailVC,NSData *data);
@interface Detail1ViewController ()

@end

@implementation Detail1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _didHTMLHander = ^(Detail1ViewController *detial,NSData *data){
//        [self loadData:data];
//    };
}

- (void)loadData:(NSData *)data
{

}

- (void)getHTML:(NSString *)urlStr 
{
    AFHTTPRequestOperationManager *httpRequset = [AFHTTPRequestOperationManager manager];
    httpRequset.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak typeof(self) weakSelf = self;
    [httpRequset GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf jieXiHTML:responseObject hander:^(Detail1ViewController *detailVC, NSData *data) {
            [weakSelf loadData:data];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"load error");
    }];
}

- (void)jieXiHTML:(NSData *)data hander:(DidHTMLHander)hander
{
    
    self.didHTMLHander(self,data);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
