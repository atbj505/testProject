//
//  TestWebViewController.h
//  testWebView
//
//  Created by Robert on 15/10/26.
//  Copyright © 2015年 NationSky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TestWebType) {
    TestWebTypeUIWebView = 1,
    TestWebTypeWKWebView
};

@interface TestWebViewController : UIViewController

@property (nonatomic ,assign)TestWebType webType;

- (instancetype)initWithType:(TestWebType)type;

@end
