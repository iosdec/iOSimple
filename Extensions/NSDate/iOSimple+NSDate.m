//
//  iOSimple+NSDate.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land.
//

#import "iOSimple+NSDate.h"

@implementation NSDate (iOSimple_NSDate)

+ (NSDate *)UTCStringToDate:(NSString *)string {
    return [[self UTCFormatter] dateFromString:string];
}

+ (NSString *)dateToUTCString:(NSDate *)date {
    return [[self UTCFormatter] stringFromDate:date];
}

+ (NSDateFormatter *)UTCFormatter {
    NSDateFormatter *formatter  =   [[NSDateFormatter alloc] init];
    formatter.dateFormat        =   @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    return formatter;
}

@end
