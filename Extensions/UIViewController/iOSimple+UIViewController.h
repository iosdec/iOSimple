//
//  iOSimple+UIViewController.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "iOSimple.h"

@interface UIViewController (iOSimple_UIViewController)

- (void)addHandlerWithName:(NSString *)name selector:(SEL)selector;
- (void)addHandlerWithName:(NSString *)name selector:(SEL)selector sender:(id)sender;
- (void)postNotificationWithName:(NSString *)name;
- (void)clearHandlerWithName:(NSString *)name;
- (void)clearHandlerWithName:(NSString *)name sender:(id)sender;
- (void)clearAllHandlers;

@end

@interface NSHandler : NSObject

+ (id)sharedHandler;
- (void)postNotificationWithName:(NSString *)name;
- (void)postNotificationWithName:(NSString *)name object:(id)object;

@end
