//
//  ShareHelper.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Finder.h"

@interface ShareHelper : NSObject

+ (id)sharedHelper;
- (void)presentShareWithContent:(NSArray *)content source:(id)sourceView;
- (void)presentActivityController:(UIActivityViewController *)shareController source:(UIView *)view completion:(void(^)(BOOL shared, BOOL error))completion;

@end
