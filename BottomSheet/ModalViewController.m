//
//  ModalViewController.m
//  BottomSheet
//
//  Created by ZB on 2024/6/13.
//

#import "ModalViewController.h"
#import <Masonry.h>

@interface ModalViewController ()
@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(self.view.frame)-30, 300)];
    lab.text = @"描述：如果自定义停留点的外部输入（例如捕获的属性）发生变化，调用此方法通知表单在下一个布局传递中重新评估停留点。如果 detents 仅包含系统停留点，或者自定义停留点仅使用传入的上下文信息，则无需调用此方法。在 animateChanges: 块中调用此方法以动画方式将自定义停留点调整到新高度。";
    lab.font = [UIFont systemFontOfSize:18];
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:lab];
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

- (void)dealloc{
    NSLog(@"喔！我死了");
}

@end
