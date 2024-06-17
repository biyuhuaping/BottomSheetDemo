//
//  SimpleModalAnimator.h
//  BottomSheet
//
//  Created by ZB on 2024/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimpleModalAnimator : NSObject <UIViewControllerAnimatedTransitioning>

/// 展示/收起
@property (nonatomic, assign) BOOL isPresenting;

@end


NS_ASSUME_NONNULL_END
