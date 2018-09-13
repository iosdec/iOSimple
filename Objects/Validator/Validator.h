//
//  Validator.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Validator : NSObject

+ (void)checkForEntryString:(NSString *)string response:(NSDictionary *)response result:(void(^)(NSString *result))resultHandler;
+ (void)checkForEntryDictionary:(NSString *)string response:(NSDictionary *)response result:(void(^)(NSDictionary *result))resultHandler;
+ (void)checkForEntryArray:(NSString *)string response:(NSDictionary *)response result:(void(^)(NSArray *result))resultHandler;
+ (BOOL)isValidEntity:(id)entity;
+ (BOOL)isValidEmail:(NSString *)email;
+ (BOOL)isValidPassword;
+ (NSDate *)validateDate:(NSString *)dateString;
+ (NSString *)validateDateToString:(NSDate *)date withTime:(BOOL)withTime pretty:(BOOL)pretty;

@end
