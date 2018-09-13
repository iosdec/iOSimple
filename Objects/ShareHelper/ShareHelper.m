//
//  ShareHelper.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "ShareHelper.h"

@implementation ShareHelper

+ (id)sharedHelper {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    }); return _sharedObject;
}

- (void)presentShareWithContent:(NSArray *)content source:(id)sourceView {
    if (!content || !sourceView) { return; }
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:content applicationActivities:nil];
    [self presentActivityController:controller source:sourceView];
}

- (void)presentActivityController:(UIActivityViewController *)shareController source:(UIView *)view {
    
    // for iPad: make the presentation a Popover
    shareController.modalPresentationStyle   =   UIModalPresentationPopover;
    UIViewController *topController     =   [Finder findTopViewController];
    [topController presentViewController:shareController animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [shareController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.sourceView = view;
    popController.sourceRect = view.bounds;
    
    // access the completion handler
    shareController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *error){
    };
    
}

- (void)presentActivityController:(UIActivityViewController *)shareController source:(UIView *)view completion:(void(^)(BOOL shared, BOOL error))completion {
    
    // for iPad: make the presentation a Popover
    shareController.modalPresentationStyle  =   UIModalPresentationPopover;
    UIViewController *topController         =   [Finder findTopViewController];
    [topController presentViewController:shareController animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [shareController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.sourceView = view;
    popController.sourceRect = view.bounds;
    
    // access the completion handler
    shareController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *error){
        
        if (error) {
            completion(NO, YES); return;
        } else if (completed) {
            completion(YES, NO); return;
        } else {
            completion(NO, NO); return;
        }
        
    };
    
}

@end
