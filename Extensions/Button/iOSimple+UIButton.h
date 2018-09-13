//
//  iOSimple+UIButton.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum {
    ButtonActionTypeGrow    =   0,
}ButtonActionType;

@interface ButtonAction : NSObject
@property (nonatomic, assign) SEL tempSelector;
@property (strong, nonatomic) id tempSender;
@end

@interface UIButton (iOSimple_UIButton)

- (void)addButtonTargets:(ButtonActionType)type selector:(SEL)sel sender:(id)sender;

@end
