//
//  BViewController.m
//  testWebView
//
//  Created by Robert on 16/2/17.
//  Copyright © 2016年 NationSky. All rights reserved.
//

#import "BViewController.h"
#import "CViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    lable.text = @"B";
    lable.center = self.view.center;
    [self.view addSubview:lable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CViewController *vc = [[CViewController alloc] init];
    
    NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
    
    NSArray *tempArray = @[vc, [vcs lastObject]];
    
    [vcs removeLastObject];
    
    [vcs addObjectsFromArray:tempArray];
    
    self.navigationController.viewControllers = [vcs copy];
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
