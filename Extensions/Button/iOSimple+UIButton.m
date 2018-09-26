//
//  iOSimple+UIButton.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "iOSimple+UIButton.h"

@implementation UIButton (iOSimple_UIButton)

- (void)addButtonTargets:(ButtonActionType)type selector:(SEL)sel sender:(id)sender {
    [self addTarget:self action:@selector(buttonAction_touchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(buttonAction_touchCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragExit | UIControlEventTouchDragEnter | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(buttonAction_touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    if (sel && sender) {
        [self addTarget:sender action:sel forControlEvents:UIControlEventTouchUpInside];
    }
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
