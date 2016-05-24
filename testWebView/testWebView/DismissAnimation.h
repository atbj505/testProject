//
//  DismissAnimation.h
//  testWebView
//
//  Created by Robert on 16/2/1.
//  Copyright © 2016年 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIViewControllerTransitioning.h> 
#import "CircleView.h"

@interface DismissAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) CircleView *endView;

@end
