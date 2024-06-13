#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "BottomSheetBgView.h"
#import "TableViewController.h"
#import "ModalViewController.h"

@interface ViewController ()<SheetDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, assign) CGFloat topDistance;
@property (nonatomic, strong) UIView *sheetView;

@end

@implementation ViewController{
    BottomSheetBgView *_sheetBgView;
    NSLayoutConstraint *_sheetBgTopConstraint;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)bottomSheet:(id)bottomSheet didScrollTo:(CGPoint)contentOffset {
    self.topDistance = MAX(0, -contentOffset.y);
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self showBottomView];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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

#pragma mark - Private Methods

- (void)showBottomView {
    // The sheet background
    _sheetBgView = [[BottomSheetBgView alloc] init];
    [self.view addSubview:_sheetBgView];
    _sheetBgView.translatesAutoresizingMaskIntoConstraints = NO;
    _sheetBgTopConstraint = [_sheetBgView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
    [NSLayoutConstraint activateConstraints:@[
        _sheetBgTopConstraint,
        [_sheetBgView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor],
        [_sheetBgView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [_sheetBgView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
    ]];
    
    // tableView视图一直延伸到状态栏
    TableViewController *shortcutsVC = [[TableViewController alloc] init];
    shortcutsVC.delegate = self;
    [self addChildViewController:shortcutsVC];
    self.sheetView = shortcutsVC.view;
    [self.view addSubview:_sheetView];
    _sheetView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_sheetView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [_sheetView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [_sheetView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [_sheetView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)setTopDistance:(CGFloat)topDistance {
    _topDistance = topDistance;
    _sheetBgTopConstraint.constant = topDistance;
    NSLog(@"topDistance：%.2f", topDistance);
}

@end
