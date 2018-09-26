//
//  iOSAlert.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "iOSAlert.h"
#import "Finder.h"

@implementation iOSAlert : NSObject

+ (UIViewController *)controller {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    } return topController;
}

#pragma mark    -   Alerts:

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        alert.popoverPresentationController.sourceView = [Finder findTopViewController].view;
        alert.popoverPresentationController.sourceRect = [Finder findTopViewController].view.bounds;
    }
    [[self controller] presentViewController:alert animated:YES completion:nil];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message completion:(void(^)(void))completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { completion(); }]];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        alert.popoverPresentationController.sourceView = [Finder findTopViewController].view;
        alert.popoverPresentationController.sourceRect = [Finder findTopViewController].view.bounds;
    }
    [[self controller] presentViewController:alert animated:YES completion:nil];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        alert.popoverPresentationController.sourceView = [Finder findTopViewController].view;
        alert.popoverPresentationController.sourceRect = [Finder findTopViewController].view.bounds;
    }
    [[self controller] presentViewController:alert animated:YES completion:nil];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style buttonTitle:(NSString *)buttonTitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    [alert addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:nil]];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        alert.popoverPresentationController.sourceView = [Finder findTopViewController].view;
        alert.popoverPresentationController.sourceRect = [Finder findTopViewController].view.bounds;
    }
    [[self controller] presentViewController:alert animated:YES completion:nil];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style buttonTitle:(NSString *)buttonTitle completion:(void (^)(void))completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    [alert addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion();
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        UIViewController *topcontroller = [Finder findTopViewController];
        alert.popoverPresentationController.sourceView = topcontroller.view;
        alert.popoverPresentationController.sourceRect = CGRectMake((topcontroller.view.frame.size.width/2) - 100, 100, 200, 200);
    }
    [[self controller] presentViewController:alert animated:YES completion:nil];
}

@end
