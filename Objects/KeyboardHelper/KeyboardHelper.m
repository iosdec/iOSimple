//
//  KeyboardHelper.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "KeyboardHelper.h"

@implementation KeyboardHelper : NSObject

+ (id)sharedInstance {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    }); return _sharedObject;
}

- (void)registerKeyboardWillShow:(void(^)(void))callback {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [self setKeyboardShowCallback:callback];
}

- (void)registerKeyboardWillHide {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:[UIApplication sharedApplication].keyWindow];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if (self.isKeyboardShowing) {
        self.keyboardShowCallback();
        // optional . [self removeKeyboardObserver];
        return;
    }
    NSDictionary *userInfo          =   notification.userInfo;
    CGSize keyboardSize             =   [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.keyboardSize               =   keyboardSize;
    self.keyboardHeight             =   keyboardSize.height - 4;
    self.isKeyboardShowing          =   YES;
    self.storedKeyboardSize         =   YES;
    self.keyboardShowCallback();
    // optionaal . [self removeKeyboardObserver];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo          =   notification.userInfo;
    CGSize keyboardSize             =   [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.keyboardSize               =   keyboardSize;
    self.isKeyboardShowing          =   NO;
}

+ (void)removeKeyboardObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

+ (CGFloat)keyboardHeight {
    return [[KeyboardHelper sharedInstance] keyboardHeight];
}

@end
