//
//  iOSDec_Button.m
//  Kho
//
//  Created by R3V0 on 29/05/2018.
//  Copyright © 2018 kholabs. All rights reserved.
//

#import "iOSDec_Button.h"

@implementation UIButton (iOSDec_Button)

- (void)addButtonTargets:(ButtonActionType)type selector:(SEL)sel sender:(id)sender {
    [self addTarget:self action:@selector(buttonAction_touchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(buttonAction_touchCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragExit | UIControlEventTouchDragEnter | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(buttonAction_touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction_touchDown:(UIButton *)button {
    [UIView animateWithDuration:0.2 animations:^{
        self.transform              =   CGAffineTransformMakeScale(1.06, 1.06);
    }];
}

- (void)buttonAction_touchCancel:(UIButton *)button {
    [UIView animateWithDuration:0.2 animations:^{
        self.transform              =   CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)buttonAction_touchUpInside:(UIButton *)button {
    [UIView animateWithDuration:0.2 animations:^{
        self.transform              =   CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

@end
