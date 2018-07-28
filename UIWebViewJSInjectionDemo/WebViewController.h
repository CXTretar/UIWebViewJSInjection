//
//  WebViewController.h
//  UIWebViewJSInjectionDemo
//
//  Created by Felix on 2018/7/28.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, InjectType) {
    InjectAfterFinished,
    InjectWhenLoading,
};

@interface WebViewController : UIViewController

@property (nonatomic, assign) InjectType injectMethod;

@end
