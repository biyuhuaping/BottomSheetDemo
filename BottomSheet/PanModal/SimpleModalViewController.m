//
//  SimpleModalViewController.m
//  BottomSheet
//
//  Created by ZB on 2024/6/17.
//

#import "SimpleModalViewController.h"

@interface SimpleModalViewController ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGFloat initialOffset;
@property (nonatomic, assign) CGFloat midOffset;
@property (nonatomic, assign) CGFloat maxOffset;

@property (nonatomic, strong) UIView *sheetView;

@end

@implementation SimpleModalViewController

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

- (void)handlePanGesture111:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self.view];
    CGPoint velocity = [gesture velocityInView:self.view];
    
    static CGFloat initialHeight = 0;
    static CGFloat maxHeight = 0;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        initialHeight = self.sheetView.frame.size.height;
        maxHeight = CGRectGetHeight(self.view.frame) - 100; // 最大高度
    }
    
    switch (gesture.state) {
        case UIGestureRecognizerStateChanged: {
            CGFloat newHeight = initialHeight - translation.y;
            if (newHeight < self.initialOffset) {
                newHeight = self.initialOffset;
            } else if (newHeight > maxHeight) {
                newHeight = maxHeight;
            }
            CGRect frame = self.sheetView.frame;
            frame.origin.y = CGRectGetHeight(self.view.frame) - newHeight;
            frame.size.height = newHeight;
            self.sheetView.frame = frame;
            break;
        }
        case UIGestureRecognizerStateEnded: {
            if (velocity.y > 0) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [UIView animateWithDuration:0.25 animations:^{
                    self.sheetView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - initialHeight, CGRectGetWidth(self.view.frame), initialHeight);
                }];
            }
            break;
        }
        default:
            break;
    }
}

- (UIView *)sheetView{
    if (!_sheetView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - self.initialOffset, CGRectGetWidth(self.view.frame), self.initialOffset)];
        view.backgroundColor = UIColor.whiteColor;
//        view.userInteractionEnabled = YES;
        view.layer.cornerRadius = 12;
        view.clipsToBounds = YES;
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [view addGestureRecognizer:self.panGesture];
        
        _sheetView = view;
    }
    return _sheetView;
}

@end

