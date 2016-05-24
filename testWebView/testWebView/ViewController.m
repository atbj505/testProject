//
//  ViewController.m
//  testWebView
//
//  Created by Robert on 15/10/26.
//  Copyright © 2015年 NationSky. All rights reserved.
//

#import "ViewController.h"
#import "TestWebViewController.h"
#import "RMADAddressBookTitleView.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "TestParseViewController.h"
#import "PresentAnimation.h"
#import "DismissAnimation.h"
#import "CircleView.h"
#import "TestBoltsViewController.h"
#import "TestTableViewController.h"

@interface ViewController ()<RMADAddressBookTitleViewDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *butBgView;
@property (nonatomic, strong) UIButton *leftBut;
@property (nonatomic, strong) UIButton *rightBut;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) PresentAnimation *presentAnimation;
@property (nonatomic, strong) CircleView *circleView;
@property (nonatomic, strong) DismissAnimation *dismissAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:self.imageView];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://upload.jianshu.io/users/upload_avatars/417248/13681983f4a4.jpg?imageMogr/thumbnail/90x90/quality/100"]];

//    [self setNavigationBar];
    
//    self.navigationItem.titleView = self.butBgView;
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 60, 30)];
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"UIWebView" forState:UIControlStateNormal];
    button1.titleLabel.textColor = [UIColor blackColor];
    button1.tag = 1;
    [button1 addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
//
//    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 130, 60, 30)];
//    button2.backgroundColor = [UIColor greenColor];
//    [button2 setTitle:@"Parse" forState:UIControlStateNormal];
//    button2.titleLabel.textColor = [UIColor blackColor];
//    button2.tag = 2;
//    button2.layer.cornerRadius = 10;
//    [button2.layer masksToBounds];
//    [button2 addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 70, 60, 30)];
    button3.backgroundColor = [UIColor redColor];
    [button3 setTitle:@"bolts" forState:UIControlStateNormal];
    button3.titleLabel.textColor = [UIColor blackColor];
    button3.tag = 3;
    [button3 addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(180, 70, 60, 30)];
    button4.backgroundColor = [UIColor redColor];
    [button4 setTitle:@"table" forState:UIControlStateNormal];
    button4.titleLabel.textColor = [UIColor blackColor];
    button4.tag = 4;
    [button4 addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    self.circleView = [[CircleView alloc] init];
    self.circleView.frame = CGRectMake(0, 0, 50, 50);
    self.circleView.backgroundColor = [UIColor blueColor];
    self.circleView.center = self.view.center;
    [self.view addSubview:self.circleView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCircle)];
    [self.circleView addGestureRecognizer:tap];
    
    self.presentAnimation = [[PresentAnimation alloc] init];
    self.presentAnimation.startView = self.circleView;
    
    self.dismissAnimation = [[DismissAnimation alloc] init];
    self.dismissAnimation.endView = self.circleView;
}

- (void)tapCircle {
    TestParseViewController *parse = [[TestParseViewController alloc] init];
    parse.transitioningDelegate = self;
    parse.modalPresentationStyle = UIModalPresentationCustom;
    parse.modalPresentationCapturesStatusBarAppearance = YES;
    [self presentViewController:parse animated:YES completion:nil];
    
//    CGAffineTransform transform = CGAffineTransformScale(self.circleView.transform, 4, 4);
//    [UIView animateWithDuration:1 animations:^{
//        self.circleView.transform = transform;
//    }];
}

- (void)setNavigationBar
{
    RMADAddressBookTitleView *titleView = [[RMADAddressBookTitleView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleView.titles = @[@"组织架构",@"星标联系人"];
    titleView.images = @[@"",@""];
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
}

- (void)RMADAddressBookTitleView:(RMADAddressBookTitleView *)RMADAddressBookTitleView didTapButtonIndex:(NSUInteger)index {
    
}

- (void)tapButton:(UIButton *)btn {
    if (btn.tag == 1) {
        TestWebViewController *webVC = [[TestWebViewController alloc] initWithType:btn.tag];
        [self.navigationController pushViewController:webVC animated:YES];
    }else if (btn.tag == 2) {
        TestParseViewController *parse = [[TestParseViewController alloc] init];
        parse.transitioningDelegate = self;
        [self presentViewController:parse animated:YES completion:nil];
    }else if (btn.tag == 3) {
        TestBoltsViewController *bolt = [[TestBoltsViewController alloc] init];
        [self.navigationController pushViewController:bolt animated:YES];
    }else if (btn.tag == 4) {
        TestTableViewController *table = [[TestTableViewController alloc] init];
        [self.navigationController pushViewController:table animated:YES];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:1 animations:^{
        self.imageView.frame = (CGRect){CGPointZero, self.view.frame.size};
    } completion:^(BOOL finished) {
        
    }];
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.presentAnimation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnimation;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}
@end
