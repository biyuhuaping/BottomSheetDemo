//
//  SheetContainerView.m
//  Test
//
//  Created by ZB on 2024/6/11.
//

#import "SheetContainerView.h"

@implementation SheetContainerView {
    UIView *_mainView;
    UIView *_sheetView;
    BottomSheetBackgroundView *_sheetBackground;
    NSLayoutConstraint *_sheetBackgroundTopConstraint;
}

- (instancetype)initWithMainView:(UIView *)mainView sheetView:(UIView *)sheetView {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _mainView = mainView;
        _sheetView = sheetView;
        _sheetBackground = [[BottomSheetBackgroundView alloc] init];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    // The main view fills the view completely
    [self addSubview:_mainView];
    _mainView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_mainView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [_mainView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
        [_mainView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [_mainView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];
    
    // The sheet background
    [self addSubview:_sheetBackground];
    _sheetBackground.translatesAutoresizingMaskIntoConstraints = NO;
    _sheetBackgroundTopConstraint = [_sheetBackground.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor];
    [NSLayoutConstraint activateConstraints:@[
        _sheetBackgroundTopConstraint,
        [_sheetBackground.heightAnchor constraintEqualToAnchor:self.heightAnchor],
        [_sheetBackground.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [_sheetBackground.rightAnchor constraintEqualToAnchor:self.rightAnchor]
    ]];
    
    // The sheet table view goes all the way up to the status bar
    [self addSubview:_sheetView];
    _sheetView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_sheetView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [_sheetView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
        [_sheetView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor],
        [_sheetView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];
}

- (void)setTopDistance:(CGFloat)topDistance {
    _topDistance = topDistance;
    _sheetBackgroundTopConstraint.constant = topDistance;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(_sheetBackground.bounds, [_sheetBackground convertPoint:point fromView:self])) {
        return [_sheetView hitTest:[_sheetView convertPoint:point fromView:self] withEvent:event];
    }
    return [_mainView hitTest:[_mainView convertPoint:point fromView:self] withEvent:event];
}

@end
