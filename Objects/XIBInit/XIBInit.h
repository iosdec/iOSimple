//
//  XIBInit.h
//  SuperbiOS
//
//  Created by R3V0 on 02/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface XIBInit : NSObject

/*!
 @brief Returns XIB in main bundle with same name as the class.
 @discussion Defaults to first index - returns nil if array is empty.
 @param className Class that will be translated into a string.
*/
+ (id)xibWithClass:(Class)className;

/*!
 @brief Returns XIB in main bundle with same name as the class with custom index.
 @discussion The array count will be checked against the index - returns nil if array is empty.
 @param className Class that will be translated into a string.
 @param index Index of the view in the the array.
*/
+ (id)xibWithClass:(Class)className index:(int)index;

/*!
 @brief Returns XIB in custom butndle with class name and custom index.
 @discussion Array count will be checked, and so will the bundle - returns nil if array is empty.
 @param className Class that will be translated into a string.
 @param index Index of the view in the the array.
 @param bundle Bundle to find the XIB - defaults to mainBundle if isn't set.
*/
+ (id)xibWithClass:(Class)className index:(int)index bundle:(NSBundle *)bundle;

@end
