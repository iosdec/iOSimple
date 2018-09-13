//
//  PushHandle.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface PushHandle : NSObject <UNUserNotificationCenterDelegate>

+ (id)sharedHandle;
- (void)registerForNotifications;
- (void)registerForNotificationsWithCompletion:(void(^)(BOOL registered))completion;

@end
