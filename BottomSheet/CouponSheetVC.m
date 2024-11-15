//
//  CouponSheetVC.m
//  BottomSheet
//
//  Created by ZB on 2024/11/15.
//

#import "CouponSheetVC.h"
#import <Masonry.h>

/// 屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define kHeight (SCREEN_SIZE.height)*0.7

@interface CouponSheetVC ()

@property (nonatomic, strong) UIView *darkView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation CouponSheetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupControls];
    [self show];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    } completion:^(BOOL finished) {
    }];
}

/// 设置子控件
- (void)setupControls {
    self.view.backgroundColor = UIColor.clearColor;

    // 暗黑色的view
    [self.view addSubview:self.darkView];
    self.darkView.frame = self.view.bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.darkView addGestureRecognizer:tap];
    
    [self.view addSubview:self.bottomView];
    self.bottomView.frame = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, kHeight);
    
    // 切两个圆角
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_bottomView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:(CGSize){8.0}];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    _bottomView.layer.mask = shapeLayer;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 49)];
    topView.backgroundColor = UIColor.whiteColor;
    [self.bottomView addSubview:topView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width/2-30, 10, 60, 25)];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = UIColor.blackColor;
    titleLabel.text = @"优惠券";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setImage:[UIImage imageNamed:@"shop_coupon_exit"] forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    exitButton.frame = CGRectMake(SCREEN_SIZE.width-46, 0, 46, 46);
    [topView addSubview:exitButton];
}

#pragma mark - 显示隐藏弹框

- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
//        self.darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        CGRect frame = self.bottomView.frame;
        frame.origin.y -= frame.size.height;
        self.bottomView.frame = frame;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        CGRect frame = self.bottomView.frame;
        frame.origin.y += frame.size.height;
        self.bottomView.frame = frame;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - lazy
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = UIColor.greenColor;
    }
    return _bottomView;
}

- (UIView *)darkView {
    if (!_darkView) {
        _darkView = [UIView new];
        _darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return _darkView;
}

- (void)dealloc{
    NSLog(@"喔！CouponSheetVC死了");
}

@end
