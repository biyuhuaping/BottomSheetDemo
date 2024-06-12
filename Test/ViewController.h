//
//  ViewController.h
//  Test
//
//  Created by ZB on 2022/6/27.
//

#import <UIKit/UIKit.h>
#import "BottomSheetDelegate.h"
#import "BotSheet.h"

@interface ViewController : UIViewController <BottomSheetDelegate>

- (instancetype)initWithMainViewController:(UIViewController *)mainViewController
                        sheetViewController:(UIViewController<BotSheet> *)sheetViewController;

@end
