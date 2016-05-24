//
//  TestTableViewController.m
//  testWebView
//
//  Created by Robert on 16/2/5.
//  Copyright © 2016年 NationSky. All rights reserved.
//

#import "TestTableViewController.h"

@interface TestTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [self.tableView setContentInset:UIEdgeInsetsMake(300, 0, 0, 0)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -150, self.view.bounds.size.width, 300)];
    self.imageView.image = [UIImage imageNamed:@"1.png"];
    self.imageView.layer.anchorPoint = CGPointMake(0.5f, 0);
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
//    [UIView beginAnimations:nil context:nil];
    [self makeParallaxEffect];
//    [UIView commitAnimations];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [UIView beginAnimations:nil context:nil];
    self.navigationController.navigationBar.alpha = 1;
//    [UIView commitAnimations];
    
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (object == self.tableView) {
        [self makeParallaxEffect];
    }
}

- (void)makeParallaxEffect {
    CGPoint point = [((NSValue *) [self.tableView valueForKey:@"contentOffset"]) CGPointValue];
    if (point.y < -300) {
        float scaleFactor = fabs(point.y) / 300.f;
        self.imageView.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    } else {
        self.imageView.transform = CGAffineTransformMakeScale(1, 1);
    }
    
    if (point.y <= 0) {
        if (point.y >= -300) {
            self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, 0, (fabs(point.y) - 300) / 2.f);
        }
        self.imageView.alpha = fabs(point.y / 300.f);
        self.navigationController.navigationBar.alpha = 1 - powf(fabs(point.y / 300.f), 3);
    } else {
        self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, 0, 0);
        self.imageView.alpha = 0;
        self.navigationController.navigationBar.alpha = 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 23;
}

static NSString *identifier = @"identifier";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

@end
