//
//  TitleItem.m
//  BottomSheet
//
//  Created by ZB on 2024/7/18.
//

#import "TitleItem.h"

@interface TitleItem()

@property (nonatomic, strong) UILabel *titleLab;

@end


@implementation TitleItem

- (void)setName:(NSString *)name {
    _name = name;
    self.titleLab.text = name;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.titleLab.textColor = isSelected ? ColorFromHex(0x292933) : ColorFromHex(0x676773);
    self.titleLab.font = isSelected ? [UIFont boldSystemFontOfSize:18] : [UIFont boldSystemFontOfSize:15];
}

- (void)updateFontSizeWithProgress:(CGFloat)progress {
    CGFloat minFontSize = 15.0;
    CGFloat maxFontSize = 18.0;
    CGFloat fontSize = minFontSize + (maxFontSize - minFontSize) * progress;
    self.titleLab.font = [UIFont boldSystemFontOfSize:fontSize];
}

#pragma mark - LifeCycle
- (instancetype)init{
    self = [super init];
    if (self) {
        [self installSubViews];
    }
    return self;
}

- (void)installSubViews {
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.greaterThanOrEqualTo(@66);
        make.height.greaterThanOrEqualTo(@26);
    }];
}

#pragma mark - 懒加载
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"自营";
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = ColorFromHex(0x292933);
        _titleLab.font = [UIFont boldSystemFontOfSize:18];
    }
    return _titleLab;
}

@end
