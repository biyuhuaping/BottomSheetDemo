//
//  SheetContainerView.h
//  Test
//
//  Created by ZB on 2024/6/11.
//

#import <UIKit/UIKit.h>
#import "BottomSheetBackgroundView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SheetContainerView : UIView

@property (nonatomic, assign) CGFloat topDistance;

- (instancetype)initWithMainView:(UIView *)mainView sheetView:(UIView *)sheetView;

@end


NS_ASSUME_NONNULL_END
