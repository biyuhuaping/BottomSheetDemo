//
//  BottomSheetDelegate.h
//  Test
//
//  Created by ZB on 2024/6/11.
//

// BottomSheetDelegate.h
#import <UIKit/UIKit.h>

@protocol BottomSheetDelegate <NSObject>
- (void)bottomSheet:(id)bottomSheet didScrollTo:(CGPoint)contentOffset;
@end



