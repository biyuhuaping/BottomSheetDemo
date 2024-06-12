#import "ViewController.h"
#import "SheetContainerView.h"
#import "BottomSheetBackgroundView.h"

@interface ViewController ()
@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, strong) UIViewController<BotSheet> *sheetViewController;
@property (nonatomic, strong) SheetContainerView *sheetContainerView;
@end

@implementation ViewController

- (instancetype)initWithMainViewController:(UIViewController *)mainViewController
                        sheetViewController:(UIViewController<BotSheet> *)sheetViewController {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _mainViewController = mainViewController;
        _sheetViewController = sheetViewController;
        
        [self addChildViewController:mainViewController];
        [self addChildViewController:sheetViewController];
        
        sheetViewController.delegate = self;
    }
    return self;
}

- (void)loadView {
    _sheetContainerView = [[SheetContainerView alloc] initWithMainView:_mainViewController.view sheetView:_sheetViewController.view];
    self.view = _sheetContainerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mainViewController didMoveToParentViewController:self];
    [_sheetViewController didMoveToParentViewController:self];
}

- (void)bottomSheet:(id<BotSheet>)bottomSheet didScrollTo:(CGPoint)contentOffset {
    _sheetContainerView.topDistance = MAX(0, -contentOffset.y);
}

@end
