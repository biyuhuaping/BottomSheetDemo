//
//  SimpleModalVC.h
//  BottomSheet
//
//  Created by ZB on 2024/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimpleModalVC : UIViewController

@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, strong) UIView *sheetView;

- (id)initWithView:(UIView *)view height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
