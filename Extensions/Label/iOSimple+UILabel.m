//
//  iOSimple+UILabel.m
//  SuperbiOS
//
//  Created by R3V0 on 04/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import "iOSimple+UILabel.h"

@implementation UILabel (iOSimple_UILabel)

#pragma mark    -   Calculated Width:

- (CGFloat)calculatedWidth {
    return self.intrinsicContentSize.width;
}

#pragma mark    -   Calculated Width with minimum:

- (CGFloat)calculatedWidthWithMinimum:(CGFloat)minimum {
    
    CGFloat expected = [self calculatedWidth];
    
    if (expected < minimum) {
        return minimum;
    } else {
        return expected;
    }
    
}

#pragma mark    -   Calculated Width with minimum and maximum:

- (CGFloat)calculatedWidthWithMinimum:(CGFloat)minimum maximum:(CGFloat)maximum {
    
    CGFloat expectedWithMinimum = [self calculatedWidthWithMinimum:minimum];
    
    if (expectedWithMinimum < minimum) {
        return minimum;
    } else if (expectedWithMinimum > maximum) {
        return maximum;
    } else {
        return expectedWithMinimum;
    }
    
}

@end
