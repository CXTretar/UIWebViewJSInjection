//
//  WebViewController.m
//  UIWebViewJSInjectionDemo
//
//  Created by Felix on 2018/7/28.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"https://hao.360.cn/"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return  YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

#pragma mark - InjectAfterFinished 在此处注入JS

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (_injectMethod == InjectAfterFinished) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"night_mode" ofType:@"js"];
        NSString *jsStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        [webView stringByEvaluatingJavaScriptFromString:jsStr];
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}



@end
