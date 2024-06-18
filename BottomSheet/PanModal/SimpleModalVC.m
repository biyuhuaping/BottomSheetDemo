//
//  SimpleModalVC.m
//  BottomSheet
//
//  Created by ZB on 2024/6/17.
//

#import "SimpleModalVC.h"

@interface SimpleModalVC ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, assign) CGFloat midHeight;
@property (nonatomic, assign) CGFloat maxHeight;

@end

@implementation SimpleModalVC

- (id)initWithView:(UIView *)view height:(CGFloat)height{
    self = [super init];
    if (self) {
        self.viewHeight = height;
        self.sheetView = view;
        
        view.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - self.viewHeight, CGRectGetWidth(self.view.frame), self.viewHeight);
        view.layer.cornerRadius = 12;
        view.clipsToBounds = YES;
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [view addGestureRecognizer:self.panGesture];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewHeight = 300;
    self.midHeight = 450; // 中间高度
    self.maxHeight = CGRectGetHeight(self.view.frame) - 100; // 最大高度，距离顶部100
    
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
            newY = MIN(MAX(newY, CGRectGetHeight(self.view.frame) - self.maxHeight), CGRectGetHeight(self.view.frame) - self.viewHeight);
            self.sheetView.frame = CGRectMake(0, newY, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - newY);
            [gesture setTranslation:CGPointZero inView:self.view];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGFloat targetOffset = [self targetHeightForCurrentY:self.sheetView.frame.origin.y velocity:velocity.y];
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
- (CGFloat)targetHeightForCurrentY:(CGFloat)currentY velocity:(CGFloat)velocity {
    CGFloat currentOffset = CGRectGetHeight(self.view.frame) - currentY;
    CGFloat closestOffset = self.viewHeight;

    if (fabs(currentOffset - self.midHeight) < fabs(currentOffset - closestOffset)) {
        closestOffset = self.midHeight;
    }
    if (fabs(currentOffset - self.maxHeight) < fabs(currentOffset - closestOffset)) {
        closestOffset = self.maxHeight;
    }

    if (velocity > 0) { // 向下滑动
        if (currentOffset > closestOffset) {
            closestOffset = currentOffset > self.midHeight ? self.midHeight : self.viewHeight;
        }
    } else { // 向上滑动
        if (currentOffset < closestOffset) {
            closestOffset = currentOffset < self.midHeight ? self.midHeight : self.maxHeight;
        }
    }
    return closestOffset;
}

#pragma mark - lazy
- (UIView *)sheetView{
    if (!_sheetView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - self.viewHeight, CGRectGetWidth(self.view.frame), self.viewHeight)];
        view.backgroundColor = UIColor.whiteColor;
        view.layer.cornerRadius = 12;
        view.clipsToBounds = YES;
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [view addGestureRecognizer:self.panGesture];
        
        
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(view.frame)-30, 240)];
        lab.text = @"描述：如果自定义停留点的外部输入（例如捕获的属性）发生变化，调用此方法通知表单在下一个布局传递中重新评估停留点。如果 detents 仅包含系统停留点，或者自定义停留点仅使用传入的上下文信息，则无需调用此方法。在 animateChanges: 块中调用此方法以动画方式将自定义停留点调整到新高度。";
        lab.font = [UIFont systemFontOfSize:18];
        lab.numberOfLines = 0;
        lab.lineBreakMode = NSLineBreakByCharWrapping;
        [view addSubview:lab];
        
        _sheetView = view;
    }
    return _sheetView;
}

@end

