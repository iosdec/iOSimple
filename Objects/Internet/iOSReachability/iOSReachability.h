//
//  iOSReachability.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <Foundation/Foundation.h>

@interface iOSReachability : NSObject

+ (BOOL)isConnected;

@end
