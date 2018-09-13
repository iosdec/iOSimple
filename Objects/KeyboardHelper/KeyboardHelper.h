//
//  KeyboardHelper.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface KeyboardHelper : NSObject <UITextFieldDelegate>

+ (id)sharedInstance;
+ (CGFloat)keyboardHeight;
+ (void)removeKeyboardObserver;

@property (nonatomic, assign) BOOL storedKeyboardSize;
@property (nonatomic, assign) BOOL isKeyboardShowing;
@property (nonatomic, assign) CGSize keyboardSize;
@property (nonatomic, assign) CGFloat keyboardHeight;

typedef void (^KeyboardHelperWillShowCallback)(void);
@property (nonatomic, copy) KeyboardHelperWillShowCallback keyboardShowCallback;

- (void)registerKeyboardWillShow:(void(^)(void))callback;
- (void)registerKeyboardWillHide;

@end
