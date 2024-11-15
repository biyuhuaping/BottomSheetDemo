//
//  TitleView.m
//  BottomSheet
//
//  Created by ZB on 2024/7/18.
//

#import "TitleView.h"
#import "TitleItem.h"

const CGFloat ShopSilderWidth = 18.0;

@interface TitleView()

@property (nonatomic, strong) NSMutableArray<TitleItem *> * items;
@property (nonatomic, strong) UIView *silderView;
@property (nonatomic, assign) NSInteger curIndex;

@end

@implementation TitleView

#pragma mark - LifeCycle
- (instancetype)init{
    self = [super init];
    if (self) {
        self.curIndex = 0;
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addSubview:self.silderView];

    for (NSInteger index = 0; index < titleArray.count; index ++) {
        TitleItem * item = [[TitleItem alloc] init];
        item.tag = index;
        item.name = titleArray[index];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItemAction:)];
        [item addGestureRecognizer:tap];
        
        [self addSubview:item];
        [self.items addObject:item];
    }
    
    [self.items mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:35 leadSpacing:0 tailSpacing:0];
    [self.items mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-4);
        make.top.equalTo(self);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setUnderLineFrameWithfromIndex:0 toIndex:0 animated:NO];
    });
}

#pragma mark - ScrollAction
- (void)setUnderLineFrameWithfromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    self.curIndex = toIndex;
    UIView *progressView = self.silderView;
    if (progressView.isHidden) {
        return;
    }
    
    CGRect fromCellFrame = self.items[fromIndex].frame;
    CGRect toCellFrame = self.items[toIndex].frame;
    
    CGFloat progressFromEdging = ShopSilderWidth > 0 ? (fromCellFrame.size.width - ShopSilderWidth)/2 : 0;
    CGFloat progressToEdging = ShopSilderWidth > 0 ? (toCellFrame.size.width - ShopSilderWidth)/2 : 0;
    CGFloat progressY = CGRectGetHeight([self.items objectAtIndex:toIndex].frame);
    CGFloat progressX = 0, width = 0;
    
    if (fromCellFrame.origin.x < toCellFrame.origin.x) {
        if (progress <= 0.5) {
            progressX = fromCellFrame.origin.x + progressFromEdging;
            width = (toCellFrame.size.width - progressToEdging + progressFromEdging + ShopSilderWidth) * 2 * progress + fromCellFrame.size.width - 2 * progressFromEdging;
            [self changeItemStatusWithFromIndex:toIndex toIndex:fromIndex];
        } else {
            progressX = fromCellFrame.origin.x + progressFromEdging + (fromCellFrame.size.width - progressFromEdging + progressToEdging + ShopSilderWidth) * (progress - 0.5) * 2;
            width = CGRectGetMaxX(toCellFrame) - progressToEdging - progressX;
            [self changeItemStatusWithFromIndex:fromIndex toIndex:toIndex];
        }
    } else {
        if (progress <= 0.5) {
            progressX = fromCellFrame.origin.x + progressFromEdging - (toCellFrame.size.width - progressToEdging + progressFromEdging + ShopSilderWidth) * 2 * progress;
            width = CGRectGetMaxX(fromCellFrame) - progressFromEdging - progressX;
            [self changeItemStatusWithFromIndex:toIndex toIndex:fromIndex];
        } else {
            progressX = toCellFrame.origin.x + progressToEdging;
            width = (fromCellFrame.size.width - progressFromEdging + progressToEdging + ShopSilderWidth) * (1 - progress) * 2 + toCellFrame.size.width - 2 * progressToEdging;
            [self changeItemStatusWithFromIndex:fromIndex toIndex:toIndex];
        }
    }
    
    [self.items[fromIndex] updateFontSizeWithProgress:1 - progress];
    [self.items[toIndex] updateFontSizeWithProgress:progress];
    
    progressView.frame = CGRectMake(progressX, progressY, width, 4);
}

- (void)setUnderLineFrameWithfromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    self.curIndex = toIndex;
    UIView *progressView = self.silderView;
    if (self.silderView.isHidden) {
        return;
    }
    
    [self changeItemStatusWithFromIndex:fromIndex toIndex:toIndex];
    
    CGRect cellFrame = [self.items objectAtIndex:toIndex].frame;
    CGFloat progressHorEdging = ShopSilderWidth > 0 ? (cellFrame.size.width - ShopSilderWidth)/2 : 0;
    CGFloat progressX = cellFrame.origin.x + progressHorEdging;
    CGFloat progressY = CGRectGetHeight([self.items objectAtIndex:toIndex].frame);
    CGFloat width = cellFrame.size.width - 2 * progressHorEdging;
    
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            progressView.frame = CGRectMake(progressX, progressY, width, 4);
        } completion:^(BOOL finished) {
        }];
    } else {
        progressView.frame = CGRectMake(progressX, progressY, width, 4);
    }
}

- (void)changeItemStatusWithFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    self.items[fromIndex].isSelected = NO;
    self.items[toIndex].isSelected = YES;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Events
- (void)tapItemAction:(UITapGestureRecognizer *)sender {
    [self.delegate shopSelectItemFromIndex:self.curIndex toIndex: sender.view.tag];
    [self setUnderLineFrameWithfromIndex:self.curIndex toIndex:sender.view.tag animated:YES];
    self.curIndex = sender.view.tag;
}

#pragma mark - lazy
- (NSMutableArray<TitleItem *> *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (UIView *)silderView {
    if (!_silderView) {
        _silderView = [[UIView alloc] init];
        _silderView.backgroundColor = ColorFromHex(0x00B377);
        _silderView.layer.cornerRadius = 2;
        _silderView.layer.masksToBounds = YES;
    }
    return _silderView;
}

@end

