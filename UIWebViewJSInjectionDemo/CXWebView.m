//
//  CXWebView.m
//  UIWebViewJSInjectionDemo
//
//  Created by Felix on 2018/8/2.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "CXWebView.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define WEB_GOT_TITLE @"webView:didReceiveTitle:forFrame:"

@implementation CXWebView

void MethodSwizzle(Class c,SEL origSEL,SEL overrideSEL) {
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod= class_getInstanceMethod(c, overrideSEL);
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod),method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(c,overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else {
        method_exchangeImplementations(origMethod,overrideMethod);
    }
}

+ (void)initialize{
    if (self == [CXWebView class]) {
        @autoreleasepool {
            MethodSwizzle([CXWebView class], NSSelectorFromString(WEB_GOT_TITLE), @selector(cx_WebView:didReceiveTitle:forFrame:));
        }
    }
}

- (void)cx_WebView:(id)sender didReceiveTitle:(id)title forFrame:(id)frame {
    
    if(![title isKindOfClass:[NSString class]])
        return;
    if ([self respondsToSelector:@selector(cx_WebView:didReceiveTitle:forFrame:)]) {
        ((void(*)(id, SEL, id, id, id)) objc_msgSend)(self, @selector(cx_WebView:didReceiveTitle:forFrame:), sender, title, frame);
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"night_mode" ofType:@"js"];
    NSString *jsStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    [self stringByEvaluatingJavaScriptFromString:jsStr];

}

@end
