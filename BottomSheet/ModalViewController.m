//
//  ModalViewController.m
//  BottomSheet
//
//  Created by ZB on 2024/6/13.
//

#import "ModalViewController.h"
#import <Masonry.h>
#import <TYPagerController/TYPagerController.h>
#import "TitleView.h"

@interface ModalViewController ()<TYPagerControllerDelegate, TYPagerControllerDataSource, TitleViewDelegate>

@property (nonatomic, strong) TitleView * titleView;
@property (nonatomic, strong) TYPagerController * pageController;
@property (nonatomic, strong) NSMutableArray<NSString *> *pageTitles;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
//    self.titleView.frame = CGRectMake(0, 0, 200, 44);
//    self.navigationItem.titleView = self.titleView;
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(34);
    }];
    
    [self.view addSubview:self.pageController.view];
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
}

#pragma mark - HWPanModalPresentable
- (HWBackgroundConfig *)backgroundConfig {
    HWBackgroundConfig *backgroundConfig = [HWBackgroundConfig configWithBehavior:HWBackgroundBehaviorDefault];
    backgroundConfig.backgroundAlpha = 0.1;
    return backgroundConfig;
}

- (BOOL)showDragIndicator {
    return NO;
}

- (UIScrollView *)panScrollable {
    return nil;
}

- (PanModalHeight)longFormHeight {
    return PanModalHeightMake(PanModalHeightTypeContent, 240);
}

#pragma mark - TYPagerControllerDelegate, TYPagerControllerDataSource
- (NSInteger)numberOfControllersInPagerController {
    return 2;
}

- (nonnull UIViewController *)pagerController:(nonnull TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    UIViewController * listVC = [[UIViewController alloc] init];
    listVC.view.backgroundColor = index == 0 ? UIColor.greenColor : UIColor.redColor;
    return listVC;
}

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [self.titleView setUnderLineFrameWithfromIndex:fromIndex toIndex:toIndex animated:animated];
}

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [self.titleView setUnderLineFrameWithfromIndex:fromIndex toIndex:toIndex progress:progress];
}

#pragma mark - YBMShopListTitleViewDelegate
- (void)shopSelectItemFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    [self.pageController scrollToControllerAtIndex:toIndex animate:YES];
}

#pragma mark - lazy
- (TitleView *)titleView {
    if(!_titleView) {
        _titleView = [[TitleView alloc] init];
        _titleView.delegate = self;
    }
    return _titleView;
}

- (TYPagerController *)pageController {
    if (!_pageController) {
        _pageController = [[TYPagerController alloc] init];
        _pageController.delegate = self;
        _pageController.dataSource = self;
        _pageController.view.backgroundColor = [UIColor whiteColor];
        _pageController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
        [self addChildViewController:_pageController];
    }
    return _pageController;
}

#pragma mark -
- (void)dealloc{
    NSLog(@"喔！ModalViewController死了");
}

@end
