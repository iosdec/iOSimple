//
//  NSLocalDate.h
//  SuperbiOS
//
//  Created by R3V0 on 03/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSLocalDate : NSObject

/*!
 @brief Local Date from String (dd/MM/yyyy - HH:mm:ss).
 @discussion String must follow given pattern.
*/

+ (NSDate *)localDateFromString:(NSString *)string;

/*!
 @brief Local String from Date (dd/MM/yyyy - HH:mm:ss).
 @discussion String will be delivered back in given pattern.
*/

+ (NSString *)localStringFromDate:(NSDate *)date;

/*!
 @brief Local Date from Date.
 @discussion Converts NSDate into local.
*/

+ (NSDate *)localDateFromDate:(NSDate *)date;

@end
