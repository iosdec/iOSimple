//
//  TouchID.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface NSObject (TouchID)

- (BOOL)authAvailable;
- (void)authWithTouchID:(NSString *)reason error:(void(^)(NSError *error))error success:(void(^)(void))success invalid:(void(^)(void))invalid;

@end
