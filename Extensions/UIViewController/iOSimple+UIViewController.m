//
//  iOSimple+UIViewController.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "iOSimple+UIViewController.h"

@implementation UIViewController (iOSimple_UIViewController)

- (void)addHandlerWithName:(NSString *)name selector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:name object:nil];
}
- (void)addHandlerWithName:(NSString *)name selector:(SEL)selector sender:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:sender selector:selector name:name object:nil];
}
- (void)postNotificationWithName:(NSString *)name {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}
- (void)clearHandlerWithName:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
}
- (void)clearHandlerWithName:(NSString *)name sender:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:sender name:name object:nil];
}
- (void)clearAllHandlers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

@implementation NSHandler : NSObject

+ (id)sharedHandler {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    }); return _sharedObject;
}
- (void)postNotificationWithName:(NSString *)name {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}
- (void)postNotificationWithName:(NSString *)name object:(id)object {
    if (object) {
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
    }
}

@end
