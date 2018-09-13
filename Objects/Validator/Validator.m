//
//  Validator.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright iOSDec. All rights reserved.
//

#import "Validator.h"

@implementation Validator : NSObject

+ (void)checkForEntryString:(NSString *)string response:(NSDictionary *)response result:(void(^)(NSString *result))resultHandler {
    if ([response.allKeys containsObject:string]) {
        id _entry = response[string];
        if ([self isValidEntity:_entry]) {
            
            //  check if entity is an array
            //  if so , return string version
            
            if ([_entry isKindOfClass:[NSArray class]]) {
                NSString *string_version = [(NSArray *)_entry componentsJoinedByString:@", "];
                resultHandler(string_version);
                return;
            }
            
            //  check if it's null or not..
            
            if ([_entry isKindOfClass:[NSNull class]]) {
                return;
            }
            
            if (_entry == [NSNull null]) {
                return;
            }
            
            NSString *entry = (NSString *)_entry;
            resultHandler(entry);
            
        } else {
            
        }
    }
}

+ (void)checkForEntryDictionary:(NSString *)string response:(NSDictionary *)response result:(void(^)(NSDictionary *result))resultHandler {
    if ([response.allKeys containsObject:string]) {
        id _entry = response[string];
        
        if ([self isValidEntity:_entry]) {
            
            //  check if dictionary:
            
            if ([_entry isKindOfClass:[NSDictionary class]]) {
                resultHandler((NSDictionary *)_entry); return;
            }
            
            //  convert to dictionary:
            
            NSString *entry     =   (NSString *)_entry;
            NSData *data        =   [entry dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error      =   nil;
            id json             =   [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error) {
                resultHandler(nil);
                return;
            }
            
            //  return json:
            resultHandler((NSDictionary *)json);
            
        } else {
            
        }
    }
}

+ (void)checkForEntryArray:(NSString *)string response:(NSDictionary *)response result:(void(^)(NSArray *result))resultHandler {
    if ([response.allKeys containsObject:string]) {
        id _entry = response[string];
        if ([self isValidEntity:_entry]) {
            if ([_entry isKindOfClass:[NSArray class]]) {
                NSArray *entry = (NSArray *)_entry;
                resultHandler(entry);
            }
        } else {
            
        }
    }
}

+ (BOOL)isValidEntity:(id)entity {
    if (entity != [NSNull null] && ![entity isKindOfClass:[NSNull class]]) {
        
        //  check string:
        if ([entity isKindOfClass:[NSString class]]) {
            NSString *entry = (NSString *)entity;
            if (entry.length == 0) {
                return NO;
            } else {
                return YES;
            }
        }
        
        //  check dictionary:
        else if ([entity isKindOfClass:[NSDictionary class]]) {
            NSDictionary *entry = (NSDictionary *)entity;
            if (entry.allKeys.count == 0) {
                return NO;
            } else {
                return YES;
            }
        }
        
        //  check array:
        if ([entity isKindOfClass:[NSArray class]]) {
            NSArray *entry = (NSArray *)entity;
            if (entry.count == 0) {
                return NO;
            } else {
                return YES;
            }
        }
        
        //  convert it into a string..
        NSString *converted     =   [NSString stringWithFormat:@"%@", entity];
        if (converted) {
            if (converted.length != 0) {
                return YES;
            } else {
                return NO;
            }
        }
        
        else {
            return NO;
        }
        
    } else {
        return NO;
    }
}

+ (BOOL)isValidEmail:(NSString *)email {
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidPassword {
    return YES;
}

+ (NSDate *)validateDate:(NSString *)dateString {
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    if (dateString.length == 10) {
        fm.dateFormat = @"yyyy-MM-dd";
    } else {
        fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return [fm dateFromString:dateString];
}

+ (NSString *)validateDateToString:(NSDate *)date withTime:(BOOL)withTime pretty:(BOOL)pretty {
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd";
    if (pretty) {
        fm.dateFormat = @"d MMMM yyyy";
    }
    
    if (withTime) {
        fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        if (pretty) {
            fm.dateFormat = @"d MMMM yyyy - HH:mm";
        }
    }
    
    return [fm stringFromDate:date];
}

@end
