//
//  Finder.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "Finder.h"

@implementation Finder

+ (UIViewController *)findTopViewController {
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (rootController.presentedViewController) {
        rootController = rootController.presentedViewController;
    } return rootController;
}

+ (UINavigationController *)findNavControllerWithObject:(id)object {
    UIViewController *controller = [self findControllerWithObject:object];
    if ([controller isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)controller;
    }
    if (controller.navigationController) {
        return controller.navigationController;
    }
    return nil;
}

+ (UIViewController *)findControllerWithObject:(id)object {
    UIResponder *responder = object;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    } return (UIViewController *)responder;
}

+ (CGPoint)actualPositionOfView:(UIView *)sourceView controller:(UIViewController *)controller {
    
    UIView *temporaryView       =   sourceView;
    CGFloat x                   =   0;
    CGFloat y                   =   0;
    
    while (temporaryView) {
        
        if (temporaryView == controller.view) {
            break;
        }
        
        x += temporaryView.frame.origin.x;
        y += temporaryView.frame.origin.y;
        
        //  only update the view origins if we've
        //  checked the break..
        
        NSLog(@"origins updated with view : %@", temporaryView);
        
        temporaryView           =   temporaryView.superview;
        
    }
    
    NSLog(@"returning point | x: %f | y: %f", x, y);
    
    return CGPointMake(x, y);
    
}

+ (UIView *)rootViewWithView:(UIView *)view {
    
    UIView *cycleView           =   view;
    
    while (cycleView) {
        
        if (!cycleView.superview) { break; }
        else { cycleView = cycleView.superview; }
        
    }
    
    return cycleView;
    
}

@end
