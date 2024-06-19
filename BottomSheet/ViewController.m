#import "ViewController.h"

// 半模态视图
#import "ModalViewController.h"
#import "SimpleModalVC.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemYellowColor;
    
    CGFloat width = 80;
    CGFloat height = 50;
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.backgroundColor = UIColor.systemOrangeColor;
    btn1.frame = CGRectMake(40, 150, width, height);
    [btn1 setTitle:@"自定义" forState:UIControlStateNormal];
    [btn1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(presentModalVC1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.backgroundColor = UIColor.systemBlueColor;
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame)+20, CGRectGetMinY(btn1.frame), width, height);
    [btn2 setTitle:@"HW半模态" forState:UIControlStateNormal];
    [btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(presentModalVC2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.backgroundColor = UIColor.systemGreenColor;
    btn3.frame = CGRectMake(CGRectGetMaxX(btn2.frame)+20, CGRectGetMinY(btn1.frame), width, height);
    [btn3 setTitle:@"系统半模态" forState:UIControlStateNormal];
    [btn3 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(presentModalVC3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
}

#pragma mark - Section
// 自定义
- (void)presentModalVC1 {
    SimpleModalVC *modalVC = [[SimpleModalVC alloc] init];
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    modalVC.transitioningDelegate = self;
    [self presentViewController:modalVC animated:YES completion:nil];
}

// HW半模态
- (void)presentModalVC2 {
    ModalViewController *vc = [[ModalViewController alloc] init];
    [self presentPanModal:vc completion:^{
        
    }];
}

// 系统半模态
- (void)presentModalVC3 {
    ModalViewController *vc = [[ModalViewController alloc] init];
    // 设置 UISheetPresentationController
    if (@available(iOS 15.0, *)) {
        if (vc.sheetPresentationController) {
            UISheetPresentationController *sheet = vc.sheetPresentationController;
            
            // 支持的自定义显示大小
            if (@available(iOS 16.0, *)) {
                UISheetPresentationControllerDetent *smallDetent = [UISheetPresentationControllerDetent customDetentWithIdentifier:@"small" resolver:^CGFloat(id<UISheetPresentationControllerDetentResolutionContext> context) {
                    return 0.2 * context.maximumDetentValue;
                }];
                
                sheet.detents = @[
                    [UISheetPresentationControllerDetent customDetentWithIdentifier:nil resolver:^CGFloat(id<UISheetPresentationControllerDetentResolutionContext> context) {
                        return 200.0; // 固定大小
                    }],
                    smallDetent,
                    [UISheetPresentationControllerDetent customDetentWithIdentifier:nil resolver:^CGFloat(id<UISheetPresentationControllerDetentResolutionContext> context) {
                        return 0.5 * context.maximumDetentValue; // 占上下文最大尺寸的0.5
                    }],
                    UISheetPresentationControllerDetent.largeDetent
                ];
            } else {
                // Fallback on earlier versions
            }
            
            sheet.prefersGrabberVisible = YES;//是否在表单顶部显示一个抓手。默认值为 NO
            sheet.prefersEdgeAttachedInCompactHeight = YES;//在紧凑高度下是否将表单布局为边缘附着样式而不是全屏。默认值为 NO
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = YES;//当边缘附着时，是否允许 preferredContentSize 影响表单的宽度。设置为 NO 时，边缘附着时表单宽度始终等于容器的安全区域宽度。在紧凑宽度和常规高度下，此属性值不被尊重。默认值为 NO
            sheet.preferredCornerRadius = 10;//表单展示时的首选圆角半径
            sheet.prefersScrollingExpandsWhenScrolledToEdge = NO;
        }
    } else {
        // Fallback on earlier versions
    }
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    SimpleModalAnimator *animator = [[SimpleModalAnimator alloc] init];
    animator.isPresenting = YES;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    SimpleModalAnimator *animator = [[SimpleModalAnimator alloc] init];
    animator.isPresenting = NO;
    return animator;
}

@end
