//
//  PresentAnimation.h
//  testWebView
//
//  Created by Robert on 16/1/30.
//  Copyright © 2016年 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIViewControllerTransitioning.h> 
#import "CircleView.h"

@interface PresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) CircleView *startView;

@end
