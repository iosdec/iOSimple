//
//  iOSDec_Button.h
//  Kho
//
//  Created by R3V0 on 29/05/2018.
//  Copyright © 2018 kholabs. All rights reserved.
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

@interface UIButton (iOSDec_Button)

- (void)addButtonTargets:(ButtonActionType)type selector:(SEL)sel sender:(id)sender;

@end
