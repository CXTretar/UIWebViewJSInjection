//
//  ViewController.m
//  UIWebViewJSInjectionDemo
//
//  Created by Felix on 2018/7/24.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)normalJSInject:(id)sender {
    WebViewController *webVC = [WebViewController new];
    webVC.injectMethod = InjectAfterFinished;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)specialJSInject:(id)sender {
    WebViewController *webVC = [WebViewController new];
    webVC.injectMethod = InjectWhenLoading;
    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
