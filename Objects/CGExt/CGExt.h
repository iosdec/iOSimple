//
//  CGExt.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (CGExt)

- (void)sameRectWithNewX:(CGFloat)x;
- (void)sameRectWithNewX:(CGFloat)x y:(CGFloat)y;
- (void)sameRectWithNewY:(CGFloat)y;
- (void)sameRectWithNewWidth:(CGFloat)width;
- (void)sameRectWithNewHeight:(CGFloat)height;
- (void)sameRectWithNewHeight:(CGFloat)height y:(CGFloat)y;
- (void)sameRectWithView:(UIView *)view;
- (void)sameRectWithNewWidth:(CGFloat)width height:(CGFloat)height;
- (void)sameRectWithNewWidth:(CGFloat)width height:(CGFloat)height y:(CGFloat)y;

@end

@interface CGeometry : NSObject

+ (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;
+ (CGFloat)recalculatedViewHeight:(UIView *)view label:(UILabel *)label minHeight:(CGFloat)min;
+ (CGFloat)recalculatedViewHeight:(UIView *)view label:(UILabel *)label minHeight:(CGFloat)min maxHeight:(CGFloat)max;
+ (CGFloat)recalculatedViewHeight:(UIView *)view textView:(UITextView *)label minHeight:(CGFloat)min;

+ (CGFloat)bottomPositionOfView:(UIView *)view;

@end
