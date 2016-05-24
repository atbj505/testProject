//
//  CircleView.m
//  testWebView
//
//  Created by Robert on 16/1/30.
//  Copyright © 2016年 NationSky. All rights reserved.
//

#import "CircleView.h"


@interface CircleView ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation CircleView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.maskLayer) {
        self.maskLayer = [CAShapeLayer layer];
        self.layer.mask = self.maskLayer;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CGRectGetWidth(self.bounds) / 2.f];
    self.maskLayer.path = path.CGPath;
    
    self.layer.cornerRadius = CGRectGetWidth(self.layer.bounds) / 2.f;
}

@end
