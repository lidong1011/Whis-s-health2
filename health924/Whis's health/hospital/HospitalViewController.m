//
//  HospitalViewController.m
//  MicroHospital
//
//  Created by apple on 14-9-19.
//  Copyright (c) 2014年 Divein. All rights reserved.
//

#import "HospitalViewController.h"

@interface HospitalViewController () <UIWebViewDelegate>{
    UIWebView *_webView;
}

@end

@implementation HospitalViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setWebView];
 
}


- (void)setWebView {

    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _webView.delegate = self;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [_webView loadRequest:urlRequest];
    
    
    // 关闭webView 的反弹效果
//    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *str = @"var arr = document.getElementsByTagName('div');"
                    @"for(var i=0; i < arr.length; i++) {"
                    @"if(arr[i].className == 'top') {"
                    @"arr[i].style.display = 'none';"
                    @"}"
                    @"}";
    [webView stringByEvaluatingJavaScriptFromString:str];
    [self.view addSubview:_webView];

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"fail load");
}

@end
