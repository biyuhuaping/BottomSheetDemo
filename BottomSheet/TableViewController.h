//
//  TableViewController.h
//  Test
//
//  Created by ZB on 2024/6/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SheetDelegate <NSObject>
- (void)bottomSheet:(id)bottomSheet didScrollTo:(CGPoint)contentOffset;
@end



@interface TableViewController : UITableViewController

@property (nonatomic, weak) id<SheetDelegate> delegate;

@end


NS_ASSUME_NONNULL_END
