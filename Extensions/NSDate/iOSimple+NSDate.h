//
//  iOSimple+NSDate.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSDate (iOSimple_NSDate)

/*!
 @brief Convert UTC String to date.
 @param string UTC String to convert.
 @return NSDate Converted Date object.
*/
+ (NSDate *)UTCStringToDate:(NSString *)string;

/*!
 @brief Convert Date to UTC string.
 @param date Date to convert.
 @return NSString Converted string.
*/
+ (NSString *)dateToUTCString:(NSDate *)date;

@end
