//
//  Finder.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Finder : NSObject

/*!
 @brief Finds the top controller.
 @return UIViewController View controller instance.
*/
+ (UIViewController *)findTopViewController;

/*!
 @brief Finds the top navigation controller with a given source.
 @discussion The object must be inserted into some kind of view hierachy - otherwise it will be nil.
 @param object Object / Source to find the view from.
 @return UINavigationController UINavigationContrlller instance.
*/
+ (UINavigationController *)findNavControllerWithObject:(id)object;

/*!
 @brief Finds the nearest controller with a given source.
 @param object Object / Source to find the view from.
 @return UIViewController UIViewController instance.
*/
+ (UIViewController *)findControllerWithObject:(id)object;

/*!
 @brief Finds the actual position of a view, with a controller.
 @discussion Let's say you're presenting a custom view inside of a UIViewController.view.. the center position of the sourceView will mostly be wrong, because the position of the sourceView is only relative to it's subview. This method is extremely handy / simple and will save a lot of frustration.
 @param sourceView Source view to calculate position from.
 @param controller Controller view to break at.
 @return CGPoint Calculated point of the result.
*/
+ (CGPoint)actualPositionOfView:(UIView *)sourceView controller:(UIViewController *)controller;

/*!
 @brief Find the root view of a given view.
 @param view View to loop through.
 @return UIView View instance.
*/
+ (UIView *)rootViewWithView:(UIView *)view;

@end
