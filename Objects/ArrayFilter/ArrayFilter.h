//
//  ArrayFilter.h
//  SuperbiOS
//
//  Created by R3V0 on 04/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/*!
 @brief Filter Arrays with a custom predicate.
 @discussion Usefull in "Search" controllers.
*/
@interface ArrayFilter : NSObject

/*!
 @brief Main method for filtering an array.
 @param array Input array of objects / views.
 @param predicate Predicate string.
 @param completion Completion handler containing filtered array.
*/
+ (void)filterArray:(NSArray *)array predicate:(NSString *)predicate completion:(void(^)(NSArray *results))completion;

/*!
 @brief Extract properties from an array.
 @param array Array to extract from.
 @param property Property name to extract.
*/
+ (NSArray *)extractFromArray:(NSArray *)array property:(NSString *)property;

/*!
 @brief Completion Handler definition.
*/
typedef void (^filterCompletion) (NSArray *result);

/*!
 @brief Stored completion handler.
*/
@property (nonatomic, copy) filterCompletion completion;

@end
