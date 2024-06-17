//
//  ZBChangeNetWorkCell.m
//  goodLook
//
//  Created by ZB on 2024/1/4.
//

#import "ZBChangeNetWorkCell.h"
#import <Masonry.h>

@implementation ZBChangeNetWorkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self creatView];
    return self;
}

- (void)creatView{
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
//        make.width.mas_equalTo(60);
    }];
    
    [self.contentView addSubview:self.detailLab];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLab.mas_trailing).offset(10);
        make.trailing.mas_lessThanOrEqualTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
    }];
}

#pragma mark - lazy
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont boldSystemFontOfSize:14];
    }
    return _titleLab;
}

- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] init];
        _detailLab.font = [UIFont systemFontOfSize:14];
        _detailLab.textColor = UIColor.grayColor;
    }
    return _detailLab;
}

@end
