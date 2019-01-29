//
//  IBView.m
//  Declan Land
//
//  Created by Declan Land
//  Copyright Declan Land
//

#import "IBView.h"

@implementation IBView

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.alreadySetup) {
        [self setupView];
        self.alreadySetup = YES;
    }
}

#pragma mark    -   Setup View:

- (void)setupView {
    
    //  #   Check for border colour:
    
    if (self.borderColour) {
        [self.layer setBorderColor:self.borderColour.CGColor];
        [self.layer setBorderWidth:self.borderWidth];
    }
    
    //  #   Check for corner radius:
    
    if (self.cornerRadius) {
        [self.layer setCornerRadius:self.cornerRadius];
        [self setClipsToBounds:YES];
    }
    
}

@end
