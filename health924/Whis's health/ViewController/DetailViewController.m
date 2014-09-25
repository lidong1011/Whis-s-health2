//
//  DetailViewController.m
//  Whis's health
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "DetailViewController.h"
#import "Configuration.h"

@interface DetailViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    UIActivityIndicatorView *_activity;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initBackground];
    
}

- (void)initBackground
{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, 100, 50)];
    titleLab.font = [UIFont systemFontOfSize:26];
    titleLab.text = _titleStr;
    //    titleLab.backgroundColor = [UIColor redColor];
    titleLab.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLab;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activity.center = self.view.center;
    [_activity startAnimating];
    _activity.color=[UIColor colorWithWhite:0.4 alpha:1];
    [self.view addSubview:_activity];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight -64-49)];
    
    _webView.scalesPageToFit = YES;
//    _webView.scrollView.scrollEnabled = NO;
//    _webView.backgroundColor = [UIColor greenColor];
    _webView.delegate = self;
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1*1024*1024];
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [_webView loadRequest:urlRequest];
//    [self.view addSubview:_webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *str = @"var arr = document.getElementsByTagName('div');"
    @"for (var i = arr.length - 1; i >= 0; i--) {"
    @"if (arr[i].className == 'top') {"
    @"arr[i].style.display = 'none';"
    @"};"
    @"if (arr[i].className == 'duoshuo') {"
    @"arr[i].style.display = 'none';"
    @"};"
    @"if (arr[i].className == '') {"
    @"arr[i].style.display = 'none';"
    @"};"
    @"};";
    
    NSString *astr = @"var arr = document.getElementsByTagName('a');"
    @"for (var i = arr.length - 1; i >= 0; i--) {"
//    @"if (arr[i].className == 'top') {"
    @"arr[i].removeAttribute('href');"
//    @"};"
    @"};";
    [webView stringByEvaluatingJavaScriptFromString:astr];
    [webView stringByEvaluatingJavaScriptFromString:str];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self.view addSubview:_webView];
    [_activity stopAnimating];
    [_activity removeFromSuperview];
    NSLog(@"finish");
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
