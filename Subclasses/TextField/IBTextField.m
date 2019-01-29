//
//  IBTextField.m
//  iOSDec
//
//  Created by Declan Land.
//  Copyright Declan Land.
//

#import "IBTextField.h"

@implementation IBTextField

#pragma mark    -   Lifecycle:

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.alreadySetup) {
        [self setupView];
        self.alreadySetup = YES;
    }
}

#pragma mark    -   Setup:

- (void)setupView {
    
    if (self.borderColour) {
        self.layer.borderColor = self.borderColour.CGColor;
        self.layer.borderWidth = self.borderWidth;
    }
    
    self.layer.cornerRadius = self.cornerRadius;
    
    if (self.padding) {
        UIView *pad         =   [UIView new];
        pad.frame           =   CGRectMake(0, 0, self.padding, self.frame.size.height);
        self.leftViewMode   =   UITextFieldViewModeAlways;
        self.leftView       =   pad;
    }
    
    //  auto font:
    if (!self.dontChangeFont) {
        [self setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:12]];
    }
    
}

@end
