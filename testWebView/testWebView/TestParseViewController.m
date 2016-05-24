//
//  TestParseViewController.m
//  testWebView
//
//  Created by Robert on 16/1/29.
//  Copyright © 2016年 NationSky. All rights reserved.
//

#import "TestParseViewController.h"

@interface TestParseViewController () 


@end

@implementation TestParseViewController

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    yellowView.center = self.view.center;
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end