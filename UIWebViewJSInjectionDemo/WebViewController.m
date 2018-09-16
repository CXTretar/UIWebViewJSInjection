//
//  WebViewController.m
//  UIWebViewJSInjectionDemo
//
//  Created by Felix on 2018/7/28.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "WebViewController.h"
#import "CXWebView.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    NSURL *url = [NSURL URLWithString:@"https://hao.360.cn/"];
    if (_injectMethod == InjectWhenLoading) {
        CXWebView *webView = [[CXWebView alloc]initWithFrame:self.view.bounds];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        [self.view addSubview:webView];
    }else {
        UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        webView.delegate = self;
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        [self.view addSubview:webView];
    }
    //    NSURL *url = [NSURL URLWithString:@"https://hao.360.cn/"];
    
    //    https://mbd.baidu.com/newspage/data/landingpage?s_type=news&dsp=wise&context=%7B%22nid%22%3A%22news_9733004085931670566%22%7D&pageType=1&n_type=1&p_from=-1&innerIframe=1#viewportType=virtual&paddingTop=54&pageType=&pageInfo=
    
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
