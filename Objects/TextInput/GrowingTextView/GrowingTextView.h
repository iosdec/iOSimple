//
//  GrowingTextView.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kNO_GrowingTextViewDismiss @"kNO_GrowingTextViewDismiss"

@interface GrowingTextField : UIView <UITextViewDelegate> {
    CGFloat kKeyBoardHeight;
    NSDictionary *keyboardInfo;
    UIView *kRootView;
}

- (id)initWithController:(UIViewController *)controller;
- (id)initWithController:(UIViewController *)controller originalText:(NSString *)original;
- (void)presentGrowingTextView;
- (void)presentGrowingTextViewWithCallback:(void(^)(NSString *string))callback;
- (void)dismissGrowingTextView;

typedef void (^growingTextViewCallback)(NSString *string);
@property (nonatomic, copy) growingTextViewCallback callback;

@property (strong, nonatomic) NSString *original;
@property (strong, nonatomic) UIViewController *controller;
@property (strong, nonatomic) UITextView *changeField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

