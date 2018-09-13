//
//  iOSimple+UIView.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "iOSimple+UIView.h"
#import "HapticHelper.h"

@implementation UIView (iOSimple_UIView)

- (void)setResizingMask:(MaskType)type {
    
    if (type == MaskTypeFull) {
        self.autoresizingMask   =   UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    
    if (type == MaskTypeStretchyWidth) {
        self.autoresizingMask   =   UIViewAutoresizingFlexibleWidth;
    }
    
    if (type == MaskTypeStretchyHeight) {
        self.autoresizingMask   =   UIViewAutoresizingFlexibleHeight;
    }
    
    if (type == MaskTypeStretchyWidthFull) {
        self.autoresizingMask   =   UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    
    if (type == MaskTypeStretchyHeightFull) {
        self.autoresizingMask   =   UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    
    //  still left to do
    
}

- (void)addMagicButtonWithAction:(SEL)selector sender:(id)sender {
    self.userInteractionEnabled =   YES;
    UIButton *button            =   [[UIButton alloc] init];
    button.frame                =   CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    [button setResizingMask:MaskTypeFull];
    [button addTarget:self action:@selector(buttonAction_touchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(buttonAction_touchCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragExit | UIControlEventTouchDragEnter | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside];
    [button addTarget:self action:@selector(buttonAction_touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:sender action:selector forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)buttonAction_touchDown:(UIButton *)button {
    [UIView animateWithDuration:0.2 animations:^{
        self.transform      =   CGAffineTransformMakeScale(1.02, 1.02);
    }];
}

- (void)buttonAction_touchCancel:(UIButton *)button {
    [UIView animateWithDuration:0.1 animations:^{
        self.transform      =   CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)buttonAction_touchUpInside:(UIButton *)button {
    [UIView animateWithDuration:0.1 animations:^{
        self.transform      =   CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        [HapticHelper generateFeedback:FeedbackType_Selection];
    }];
}

- (NSMutableArray *)allSubviews {
    NSMutableArray *subs = [[NSMutableArray alloc] init];
    [subs addObject:self];
    for (UIView *subview in self.subviews) {
        [subs addObjectsFromArray:(NSArray *)[subview allSubviews]];
    } return subs;
}

- (void)findViewWithIdentifier:(NSString *)identifier completion:(void (^)(id))completion {
    for (UIView *view in [self allSubviews]) {
        if ([view.restorationIdentifier isEqualToString:identifier]) {
            completion(view);
        }
    }
}

@end
