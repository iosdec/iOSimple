//
//  iOSimple+UIColour.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIColor (iOSimple_UIColour)

+ (UIColor *)colourWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (UIColor *)colourFromHexString:(NSString *)hexString;
- (NSString *)hexVersion;

@end

