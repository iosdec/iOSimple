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

@end
