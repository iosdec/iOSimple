//
//  iOSimple+UILabel.h
//  SuperbiOS
//
//  Created by R3V0 on 04/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UILabel (iOSimple_UILabel)

/*!
 @brief Calculate expected width of the label.
 @discussion This is calculated based on the label.text.
*/
- (CGFloat)calculatedWidth;

/*!
 @brief Calculate expected width with mimimum width.
 @param minimum Minimum width of the label.
*/
- (CGFloat)calculatedWidthWithMinimum:(CGFloat)minimum;

/*!
 @brief Calculate expected width with mimimum and maximum width.
 @param minimum Minimum width of the label.
 @param maximum Maximum width of the label.
*/
- (CGFloat)calculatedWidthWithMinimum:(CGFloat)minimum maximum:(CGFloat)maximum;

@end
