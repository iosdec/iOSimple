//
//  ArrayFilter.m
//  SuperbiOS
//
//  Created by R3V0 on 04/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import "ArrayFilter.h"

@implementation ArrayFilter

#pragma mark    -   Main Filter Method:

+ (void)filterArray:(NSArray *)array predicate:(NSString *)predicate completion:(void (^)(NSArray *))completion {
    
    if (!array) { completion([NSArray array]); return; }
    
    if (array.count) { completion([NSArray array]); return; }
    
    if (!predicate) { completion([NSArray array]); return; }
    
    if (predicate.length == 0) { completion([NSArray array]); return; }
    
    //  #   Create Predicate from string.
    
    NSPredicate *predicateMethod = [NSPredicate predicateWithFormat:predicate];
    
    //  #   Filter the array.
    
    completion([array filteredArrayUsingPredicate:predicateMethod]);
    
}

+ (NSArray *)extractFromArray:(NSArray *)array property:(NSString *)property {
    
    if (!array) {
        return [NSArray array];
    }
    if (!property) {
        return [NSArray array];
    }
    if (array.count == 0) {
        return [NSArray array];
    }
    if (![array valueForKey:property]) {
        return [NSArray array];
    }
    if (![[array valueForKey:property] isKindOfClass:[NSArray class]]) {
        return [NSArray array];
    }
    
    return [(NSArray *)array valueForKey:property];
    
}

@end
