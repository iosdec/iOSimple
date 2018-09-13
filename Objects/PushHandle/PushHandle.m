//
//  PushHandle.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "PushHandle.h"

@implementation PushHandle

+ (id)sharedHandle {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    }); return _sharedObject;
}

- (void)registerForNotifications {
    
    UNUserNotificationCenter *center    =   [UNUserNotificationCenter currentNotificationCenter];
    center.delegate                     =   self;
    
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }];
        }
    }];
    
}

- (void)registerForNotificationsWithCompletion:(void(^)(BOOL registered))completion {
    
    UNUserNotificationCenter *center    =   [UNUserNotificationCenter currentNotificationCenter];
    center.delegate                     =   self;
    
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
                completion(YES); return;
            }];
        } else {
            completion(NO);
        }
    }];
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    //  User clicked the notification
    //  NSLog(@"user info present : %@",notification.request.content.userInfo);
    
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    //  Notification is being presented
    //  NSLog(@"user info response : %@",response.notification.request.content.userInfo);
    
    completionHandler();
    
}

@end
