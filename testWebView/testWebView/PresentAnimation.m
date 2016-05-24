//
//  PresentAnimation.m
//  testWebView
//
//  Created by Robert on 16/1/30.
//  Copyright © 2016年 NationSky. All rights reserved.
//

#import "PresentAnimation.h"
#import <pop/POP.h>
#import <UIKit/UIKit.h>

@interface PresentAnimation ()

@end

@implementation PresentAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.35f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // 1. Get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 2. Set init frame for toVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    CircleView *tempView = [[CircleView alloc] initWithFrame:self.startView.frame];
    tempView.backgroundColor = self.startView.backgroundColor;
    tempView.layer.contents = self.startView.layer.contents;
    toVC.view = tempView;
//    [toVC.view addSubview:tempView];
    
    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    // 4. Do animate now
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    [UIView animateWithDuration:duration
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         toVC.view.frame = finalFrame;
//                     } completion:^(BOOL finished) {
//                         // 5. Tell context that we completed.
//                         [transitionContext completeTransition:YES];
//                     }];
    CGFloat scale = screenBounds.size.height / self.startView.bounds.size.height + 2;
    CGAffineTransform transform = CGAffineTransformScale(toVC.view.transform, scale, scale);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.transform = transform;
    } completion:^(BOOL finished) {
//        toVC.view.frame = fromVC.view.frame;
//        toVC.view.layer.cornerRadius = 0;
//        toVC.view.layer.masksToBounds = YES;
        [transitionContext completeTransition:YES];
    }];
    
}

@end
