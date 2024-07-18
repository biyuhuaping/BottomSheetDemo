//
//  TitleItem.h
//  BottomSheet
//
//  Created by ZB on 2024/7/18.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#define ColorFromHex(hexValue)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]


NS_ASSUME_NONNULL_BEGIN

@interface TitleItem : UIView

@property (nonatomic, strong) NSString * name;

@property (nonatomic, assign) BOOL isSelected;

- (void)updateFontSizeWithProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
