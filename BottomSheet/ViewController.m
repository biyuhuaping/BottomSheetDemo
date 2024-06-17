#import "ViewController.h"
#import <MapKit/MapKit.h>

#import "ModalViewController.h"
#import "ZBChangeNetWorkSheetView.h"

// 半模态视图
#import "SimpleModalViewController.h"
#import "SimpleModalAnimator.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, assign) CGFloat topDistance;
@property (nonatomic, strong) UIView *sheetView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 200, 50);
    [button setTitle:@"Present Modal" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentModalViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    
//    ZBChangeNetWorkSheetView *view = [[ZBChangeNetWorkSheetView alloc]init];
//    [window addSubview:view];
//    [view showView];
//    return;
    
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

#pragma mark - Section
- (void)presentModalViewController {
    SimpleModalViewController *modalViewController = [[SimpleModalViewController alloc] init];
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    modalViewController.transitioningDelegate = self;
    [self presentViewController:modalViewController animated:YES completion:nil];
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
