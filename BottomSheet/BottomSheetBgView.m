//
//  BottomSheetBackgroundView.m
//  Test
//
//  Created by ZB on 2024/6/11.
//

#import "BottomSheetBgView.h"

static CGFloat const borderWidth = 0.0;
static CGFloat const cornerRadius = 12.0;

@implementation BottomSheetBgView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = cornerRadius;
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = UIColor.orangeColor.CGColor;
        self.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Make sure border isn't visible
    CGRect newBounds = self.bounds;
    newBounds.size.width += borderWidth * 2;
    self.layer.bounds = newBounds;
}

@end

