//
//  SimpleModalVC.m
//  BottomSheet
//
//  Created by ZB on 2024/6/17.
//

#import "SimpleModalVC.h"

@interface SimpleModalVC ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGFloat initialOffset;
@property (nonatomic, assign) CGFloat midOffset;
@property (nonatomic, assign) CGFloat maxOffset;

@property (nonatomic, strong) UIView *sheetView;

@end

@implementation SimpleModalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.initialOffset = 300;
    self.midOffset = 450; // 中间高度
    self.maxOffset = CGRectGetHeight(self.view.frame) - 100; // 最大高度，距离顶部100
    
    [self.view addSubview:self.sheetView];
    
    // 添加点击手势识别器
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

// 处理点击手势
- (void)handleTapGesture:(UITapGestureRecognizer *)gesture {
    CGPoint location = [gesture locationInView:self.view];
    if (!CGRectContainsPoint(self.sheetView.frame, location)) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// 处理平移手势
- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self.view];
    CGPoint velocity = [gesture velocityInView:self.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateChanged:
            if (translation.y > 0) {
                self.view.transform = CGAffineTransformMakeTranslation(0, translation.y);
            }
            break;
        case UIGestureRecognizerStateEnded:
            if (velocity.y > 0) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [UIView animateWithDuration:0.25 animations:^{
                    self.view.transform = CGAffineTransformIdentity;
                }];
            }
            break;
        default:
            break;
    }
}

// 可以设置多个停留位置的方法，缺少弹性，暂时弃用
- (void)handlePanGesture2222:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self.view];
    CGPoint velocity = [gesture velocityInView:self.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateChanged: {
            CGFloat newY = self.sheetView.frame.origin.y + translation.y;
            newY = MIN(MAX(newY, CGRectGetHeight(self.view.frame) - self.maxOffset), CGRectGetHeight(self.view.frame) - self.initialOffset);
            self.sheetView.frame = CGRectMake(0, newY, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - newY);
            [gesture setTranslation:CGPointZero inView:self.view];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGFloat targetOffset = [self targetOffsetForCurrentY:self.sheetView.frame.origin.y velocity:velocity.y];
            [UIView animateWithDuration:0.25 animations:^{
                CGFloat newY = CGRectGetHeight(self.view.frame) - targetOffset;
                self.sheetView.frame = CGRectMake(0, newY, CGRectGetWidth(self.view.frame), targetOffset);
            }];
            break;
        }
        default:
            break;
    }
}

// 根据当前Y位置和速度来确定目标高度
- (CGFloat)targetOffsetForCurrentY:(CGFloat)currentY velocity:(CGFloat)velocity {
    CGFloat currentOffset = CGRectGetHeight(self.view.frame) - currentY;
    CGFloat closestOffset = self.initialOffset;

    if (fabs(currentOffset - self.midOffset) < fabs(currentOffset - closestOffset)) {
        closestOffset = self.midOffset;
    }
    if (fabs(currentOffset - self.maxOffset) < fabs(currentOffset - closestOffset)) {
        closestOffset = self.maxOffset;
    }

    if (velocity > 0) { // 向下滑动
        if (currentOffset > closestOffset) {
            closestOffset = currentOffset > self.midOffset ? self.midOffset : self.initialOffset;
        }
    } else { // 向上滑动
        if (currentOffset < closestOffset) {
            closestOffset = currentOffset < self.midOffset ? self.midOffset : self.maxOffset;
        }
    }
    return closestOffset;
}

#pragma mark - lazy
- (UIView *)sheetView{
    if (!_sheetView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - self.initialOffset, CGRectGetWidth(self.view.frame), self.initialOffset)];
        view.backgroundColor = UIColor.whiteColor;
        view.layer.cornerRadius = 12;
        view.clipsToBounds = YES;
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [view addGestureRecognizer:self.panGesture];
        
        _sheetView = view;
    }
    return _sheetView;
}

@end

