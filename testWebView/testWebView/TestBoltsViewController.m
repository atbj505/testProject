//
//  TestBoltsViewController.m
//  testWebView
//
//  Created by Robert on 16/2/3.
//  Copyright © 2016年 NationSky. All rights reserved.
//

#import "TestBoltsViewController.h"
#import "PromiseKit.h"

@interface TestBoltsViewController ()

@end

@implementation TestBoltsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PromiseKit" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"1", @"2", nil];
//    [alert promise].then(^(NSNumber *btnIndex){
    
//    });
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 100)];
    label.backgroundColor = [UIColor blueColor];
    label.alpha = 0.0;
    [self.view addSubview:label];
    
    dispatch_promise(^(){
        NSString *string = @"Hello world!";
        return string;
    }).then(^(NSString *title){
        [UIView promiseWithDuration:2 animations:^{
            label.alpha = 1.0;
        }];
        label.text = title;
    });
}

@end
