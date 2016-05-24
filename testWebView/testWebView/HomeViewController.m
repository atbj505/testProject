//
//  HomeViewController.m
//  testWebView
//
//  Created by Robert on 16/2/18.
//  Copyright © 2016年 NationSky. All rights reserved.
//

#import "HomeViewController.h"
#import "AViewController.h"
#import "BViewController.h"
#import "CViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) AViewController *avc;

@property (nonatomic, strong) BViewController *bvc;

@property (nonatomic, strong) CViewController *cvc;

@property (nonatomic, strong) UIViewController *currentvc;

@property (nonatomic ,strong) UIScrollView *headScrollView;

@property (nonatomic ,strong) NSArray *headArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"网易新闻Demo";
    
    self.headArray = @[@"头条",@"娱乐",@"体育",@"财经",@"科技",@"NBA",@"手机"];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, 40)];
    self.headScrollView.backgroundColor = [UIColor purpleColor];
    self.headScrollView.contentSize = CGSizeMake(560, 0);
    self.headScrollView.bounces = NO;
    self.headScrollView.pagingEnabled = YES;
    [self.view addSubview:self.headScrollView];
    for (int i = 0; i < [self.headArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0 + i*80, 0, 80, 40);
        [button setTitle:[self.headArray objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = i + 100;
        [button addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:button];
        
    }
    
    
    self.avc = [[AViewController alloc] init];
    [self.avc.view setFrame:CGRectMake(0, 104, 320, 464)];
    self.bvc = [[BViewController alloc] init];
    [self.bvc.view setFrame:CGRectMake(0, 104, 320, 464)];
    self.cvc = [[CViewController alloc] init];
    [self.cvc.view setFrame:CGRectMake(0, 104, 320, 464)];
    
    [self addChildViewController:self.avc];
    [self.view addSubview:self.avc.view];
    
    
    self.currentvc = self.avc;
}

- (void)didClickHeadButtonAction:(UIButton *)button {
    if ((self.currentvc == self.avc && button.tag == 100)||(self.currentvc == self.bvc && button.tag == 101.)) {
        return;
    }else{
        
        //  展示2个,其余一样,自行补全噢
        switch (button.tag) {
            case 100:
                [self replaceController:self.currentvc newController:self.avc];
                break;
            case 101:
                [self replaceController:self.currentvc newController:self.bvc];
                break;
            case 102:
                //.......
                break;
            case 103:
                //.......
                break;
            case 104:
                //.......
                break;
            case 105:
                //.......
                break;
            case 106:
                //.......
                break;
                //.......
            default:
                break;
        }
    }
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController {
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentvc = newController;
            
        }else{
            
            self.currentvc = oldController;
            
        }
    }];
}

@end
