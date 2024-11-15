//
//  TitleView.h
//  BottomSheet
//
//  Created by ZB on 2024/7/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TitleViewDelegate <NSObject>
- (void)shopSelectItemFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
@end


@interface TitleView : UIView

@property (nonatomic, copy) NSArray *titleArray;

@property (nonatomic, weak) id<TitleViewDelegate> delegate;

- (void)setUnderLineFrameWithfromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;

- (void)setUnderLineFrameWithfromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated;

@end


NS_ASSUME_NONNULL_END
