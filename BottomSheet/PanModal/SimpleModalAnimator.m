//
//  SimpleModalAnimator.m
//  BottomSheet
//
//  Created by ZB on 2024/6/17.
//

#import "SimpleModalAnimator.h"

@implementation SimpleModalAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    if (self.isPresenting) {
        [containerView addSubview:toVC.view];
        CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
        finalFrame.size.height = containerView.bounds.size.height / 1;
        finalFrame.origin.y = containerView.bounds.size.height - finalFrame.size.height;
        CGRect initialFrame = finalFrame;
        initialFrame.origin.y = containerView.bounds.size.height;
        toVC.view.frame = initialFrame;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.view.frame = finalFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        CGRect initialFrame = fromVC.view.frame;
        CGRect finalFrame = initialFrame;
        finalFrame.origin.y = containerView.bounds.size.height;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromVC.view.frame = finalFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end

