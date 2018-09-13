//
//  iOSimple+UINagivationController.h
//  Kho
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum {
    TransitionTypeFlip      =   1,
    TransitionTypeFade      =   2,
}TransitionType;

@interface UINavigationController (iOSimple_UINavigationController)

- (void)customPush:(UIViewController *)controller type:(TransitionType)type;
- (void)customPop:(TransitionType)type;

@end
