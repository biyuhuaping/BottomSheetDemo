//
//  BottomSheet.h
//  Test
//
//  Created by ZB on 2024/6/11.
//

// BotSheet.h
#import <UIKit/UIKit.h>
#import "BottomSheetDelegate.h"

@protocol BotSheet <NSObject>
@property (nonatomic, weak) id<BottomSheetDelegate> delegate;
@end
