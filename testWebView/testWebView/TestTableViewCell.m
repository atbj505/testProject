//
//  TestTableViewCell.m
//  testWebView
//
//  Created by Robert on 16/6/28.
//  Copyright © 2016年 NationSky. All rights reserved.
//

#import "TestTableViewCell.h"
#import "UIResponder+Router.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)testResponse:(UIButton *)sender {
    [self.nextResponder routerEventWithName:@"showNumber" userInfo:@{@"object":self.titleView.text}];
}

@end
