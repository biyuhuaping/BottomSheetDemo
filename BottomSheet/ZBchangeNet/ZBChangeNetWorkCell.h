//
//  ZBChangeNetWorkCell.h
//  goodLook
//
//  Created by ZB on 2024/1/4.
//

#import <UIKit/UIKit.h>

#define kScreenW ([[UIScreen mainScreen] bounds].size.width)
#define kScreenH [[UIScreen mainScreen] bounds].size.height
#define kScreenBounds [UIScreen mainScreen].bounds


#define isIPhoneX ({\
    BOOL iPhoneXSeries = NO;\
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {\
        if (@available(iOS 11.0, *)) {\
            UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];\
            if (mainWindow.safeAreaInsets.bottom > 0.0) {\
                iPhoneXSeries = YES;\
            }\
        }\
    }\
    iPhoneXSeries;\
})

//底部安全区域
#define kBottomSafeHeight (isIPhoneX ? 34 : 0)


NS_ASSUME_NONNULL_BEGIN

@interface ZBChangeNetWorkCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;

@end

NS_ASSUME_NONNULL_END
