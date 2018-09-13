//
//  iOSimple+UITextField.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UITextField (iOSimple_UITextField)

- (void)setPlaceholderColour:(UIColor *)colour;
- (void)setPlaceholderColour:(UIColor *)colour placeholder:(NSString *)placeholder;
- (void)setPadding:(CGFloat)width;

@end
