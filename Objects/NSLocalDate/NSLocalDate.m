//
//  NSLocalDate.m
//  SuperbiOS
//
//  Created by R3V0 on 03/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import "NSLocalDate.h"

@implementation NSLocalDate

+ (NSDateFormatter *)localDateFormatter {
    
    NSDateFormatter *fm =   [[NSDateFormatter alloc] init];
    fm.dateFormat       =   @"dd/MM/yyyy - HH:mm:ss";
    fm.timeZone         =   [NSTimeZone localTimeZone];
    return fm;
    
}

+ (NSDate *)localDateFromString:(NSString *)string {
    
    return [[self localDateFormatter] dateFromString:string];
    
}

+ (NSString *)localStringFromDate:(NSDate *)date {
    
    return [[self localDateFormatter] stringFromDate:date];
    
}

+ (NSDate *)localDateFromDate:(NSDate *)date {
    
    NSTimeZone *sourceTimeZone      =   [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone *destinationZone     =   [NSTimeZone systemTimeZone];
    NSInteger sourceGMTOffset       =   [sourceTimeZone secondsFromGMTForDate:date];
    NSInteger destinationGMTOffset  =   [destinationZone secondsFromGMTForDate:date];
    NSTimeInterval interval         =   destinationGMTOffset - sourceGMTOffset;
    return [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    
}

@end
