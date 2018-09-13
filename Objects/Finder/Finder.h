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

+ (UIViewController *)findTopViewController;
+ (UINavigationController *)findNavControllerWithObject:(id)object;
+ (UIViewController *)findControllerWithObject:(id)object;

@end
