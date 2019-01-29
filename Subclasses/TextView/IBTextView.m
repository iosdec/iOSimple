//
//  IBTextView.m
//  SuperbiOS
//
//  Created by R3V0 on 10/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import "IBTextView.h"

@implementation IBTextView

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.alreadySetup) {
        [self setupView];
        self.alreadySetup = YES;
    }
}

#pragma mark    -   Setup View:

- (void)setupView {
    
    if (self.borderColour) {
        self.layer.borderColor = self.borderColour.CGColor;
    }
    
    self.layer.borderWidth = self.borderWidth;
    self.layer.cornerRadius = self.cornerRadius;
    
}

@end
