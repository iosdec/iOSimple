//
//  iOSimple+UITextField.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "iOSimple+UITextField.h"

@implementation UITextField (iOSimple_UITextField)

- (void)setPlaceholderColour:(UIColor *)colour {
    if (self.placeholder.length == 0) { return; }
    self.attributedPlaceholder  =   [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: colour}];
}

- (void)setPlaceholderColour:(UIColor *)colour placeholder:(NSString *)placeholder {
    if (self.placeholder.length == 0) { return; }
    self.attributedPlaceholder  =   [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: colour}];
}

- (void)setPadding:(CGFloat)width {
    UIView *leftView        =   [[UIView alloc] init];
    leftView.frame          =   CGRectMake(0, 0, width, self.frame.size.height);
    self.leftView           =   leftView;
    self.leftViewMode       =   UITextFieldViewModeAlways;
}

@end
