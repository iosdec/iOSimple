//
//  TouchID.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "TouchID.h"

@implementation NSObject (TouchID)

- (BOOL)authAvailable {
    LAContext *context = [[LAContext alloc] init];
    NSError *err = nil;
    return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err];
}

- (void)authWithTouchID:(NSString *)reason error:(void(^)(NSError *))error success:(void(^)(void))success invalid:(void(^)(void))invalid {
    LAContext *context = [[LAContext alloc] init];
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL passed, NSError *errorrr) {
        if (errorrr) {
            error(errorrr);
            return;
        }
        if (success) {
            success();
            return;
        }
        if (!success) {
            invalid();
            return;
        }
    }];
}

@end
