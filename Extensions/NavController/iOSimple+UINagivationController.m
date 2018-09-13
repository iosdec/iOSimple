//
//  iOSDec_NavController.m
//  Kho
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "iOSimple+UINagivationController.h"

@implementation UINavigationController (iOSimple_UINavigationController)

- (void)customPush:(UIViewController *)controller type:(TransitionType)type {
    
    if (type == TransitionTypeFlip) {
        [self push_flip:controller];
        return;
    }
    
    if (type == TransitionTypeFade) {
        [self push_fade:controller];
        return;
    }
    
}

- (void)customPop:(TransitionType)type {
    
    if (type == TransitionTypeFlip) {
        [self pop_flip];
        return;
    }
    
    if (type == TransitionTypeFade) {
        [self pop_fade];
        return;
    }
    
}

//  =====================================================
//  Push Animations:
//  =====================================================

- (void)push_flip:(UIViewController *)controller {
    [UIView animateWithDuration:0.75 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self pushViewController:controller animated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO];
    }];
}

- (void)push_fade:(UIViewController *)controller {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    [self pushViewController:controller animated:NO];
}

//  =====================================================
//  Pop Animations:
//  =====================================================

- (void)pop_flip {
    [UIView animateWithDuration:0.75 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
    }]; [self popViewControllerAnimated:NO];
}

- (void)pop_fade {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    [self popViewControllerAnimated:NO];
}

@end
