//
//  CountriesTableViewController.h
//  Test
//
//  Created by ZB on 2024/6/11.
//

#import <UIKit/UIKit.h>
#import "BotSheet.h"

NS_ASSUME_NONNULL_BEGIN


@interface CountriesTableViewController : UITableViewController <BotSheet>

@property (nonatomic, weak) id<BottomSheetDelegate> delegate;

@end


NS_ASSUME_NONNULL_END
