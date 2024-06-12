//
//  BottomSheetBackgroundView.m
//  Test
//
//  Created by ZB on 2024/6/11.
//

// BottomSheetBackgroundView.m
#import "BottomSheetBackgroundView.h"

static CGFloat const borderWidth = 1.0;
static CGFloat const cornerRadius = 12.0;

@implementation BottomSheetBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = cornerRadius;
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

