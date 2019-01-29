//
//  Multiview.h
//  Declan Land
//
//  Created by Declan Land
//  Copyright Declan Land.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, MultiviewOption) {
    MultiviewOptionNormal           =   0,          //  Do nothing.
    MultiviewOptionAdjustLabels     =   1 << 0,     //  Automaticall ajust label size.
};

@interface Multiview : NSObject

/*!
 @brief Horizontally align multiple UIView objects.
 @discussion Keeps the same distance between eachother.
 @param views UIView objects.
 @param centerX Target X point.
 @param container The superview of the views.
*/
+ (void)horizontallyAlign:(NSArray *)views target:(CGFloat)centerX container:(id)container;

/*!
 @brief Horizontally align multiple UIView objects with options.
 @discussion Keeps the same distance between eachother.
 @param views UIView objects.
 @param centerX Target X point.
 @param container The superview of the views.
 @param options Multiview Options.
*/
+ (void)horizontallyAlign:(NSArray *)views target:(CGFloat)centerX container:(id)container options:(MultiviewOption)options;

/*!
 @brief Vertically align multiple UIView objects.
 @discussion Keeps the same distance between eachother.
 @param views UIView objects.
 @param centerY Target Y point.
 @param container The superview of the views.
*/
+ (void)verticallyAlign:(NSArray *)views target:(CGFloat)centerY container:(id)container;

/*!
 @brief Vertically align multiple UIView objects with options.
 @discussion Keeps the same distance between eachother.
 @param views UIView objects.
 @param centerY Target Y point.
 @param container The superview of the views.
 @param options Multiview options.
 */
+ (void)verticallyAlign:(NSArray *)views target:(CGFloat)centerY container:(id)container options:(MultiviewOption)options;

@end
