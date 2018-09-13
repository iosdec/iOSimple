//
//  GrowingTextView.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "GrowingTextView.h"
#import "iOSimple+UIViewController.h"

#define kGrowingTvHeight 44

@implementation GrowingTextField

- (id)initWithController:(UIViewController *)controller {
    self = [super init];
    if (self) {
        GrowingTextField *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
        if (controller) { view.controller = controller; }
        [view setupView];
        self = view;
    } return self;
}

- (id)initWithController:(UIViewController *)controller originalText:(NSString *)original {
    self = [super init];
    if (self) {
        GrowingTextField *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
        if (controller) { view.controller = controller; }
        if (original) { view.original = original; }
        [view.textView setTextColor:[self color_active]];
        [view setupView];
        self = view;
    } return self;
}

- (void)keyboardDisplayed:(NSNotification *)notification {
    NSDictionary *info  =   notification.userInfo;
    NSValue *value      =   info[UIKeyboardFrameEndUserInfoKey];
    CGRect rawFrame     =   [value CGRectValue];
    UIView *mainView    =   self.controller.view;
    CGRect keyboardFrame=   [mainView convertRect:rawFrame fromView:nil];
    kKeyBoardHeight     =   keyboardFrame.size.height;
    kRootView           =   mainView;
    
    //  check if controller has a tab bar controller:
    CGFloat tabbardif   =   0;
    if (self.controller.tabBarController) { tabbardif = self.controller.tabBarController.view.frame.size.height; }
    self.frame          =   CGRectMake(0, self.controller.view.frame.size.height - keyboardFrame.size.height - kGrowingTvHeight - tabbardif, self.controller.view.frame.size.width, kGrowingTvHeight);
}

- (CGFloat)heightCoveredByKeyboardOfSize:(CGRect)keyboardrect {
    CGRect keyboardrectConverted = [self convertRect:keyboardrect fromView: nil];
    CGFloat bottomSpace = self.bounds.size.height - keyboardrectConverted.origin.y;
    return bottomSpace;
}

- (void)setupView {
    self.frame                          =   CGRectMake(0, self.controller.view.frame.size.height, self.controller.view.frame.size.width, kGrowingTvHeight);
    self.textView.delegate              =   self;
    self.textView.layer.borderWidth     =   0.7;
    self.textView.layer.borderColor     =   [[UIColor lightGrayColor] colorWithAlphaComponent:0.7].CGColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisplayed:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisplayed:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissNotification:) name:kNO_GrowingTextViewDismiss object:nil];
}

- (void)dismissNotification:(NSNotification *)notification {
    [self dismissGrowingTextView];
}

#pragma mark    -   Presentation:

- (void)presentGrowingTextView {
    if (!self.controller) { return; }
    if (![self.controller.view.subviews containsObject:self]) {
        [self.controller.view addSubview:self];
    }
    if (self.original) {
        if (self.original.length != 0) {
            self.textView.text = self.original;
        }
    }
    [self.textView becomeFirstResponder];
}

- (void)presentGrowingTextViewWithCallback:(void (^)(NSString *))callback {
    [self setCallback:callback];
    [self presentGrowingTextView];
}

- (void)dismissGrowingTextView {
    if (!self.controller) { return; }
    [UIView animateWithDuration:0.4 animations:^{
        CGRectMake(0, self.controller.view.frame.size.height, self.controller.view.frame.size.width, kGrowingTvHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark    -   UITextView Delegate:

/*
- (void)textViewDidChange:(UITextView *)textView {
    
    CGFloat baseHeight                  =   self.frame.size.height - self.textView.frame.size.height;
    CGFloat minimumHeight               =   32;
    CGFloat calculatedHeight            =   [self findHeightForText:textView.text havingWidth:textView.frame.size.width-10 andFont:textView.font];
    CGFloat height                      =   calculatedHeight;
    if (calculatedHeight < minimumHeight) {
        height                          =   minimumHeight;
    }
    CGFloat finalHeight                 =   baseHeight + height;
    
    self.frame                  =   CGRectMake(0, self.controller.view.frame.size.height - kKeyBoardHeight, self.controller.view.frame.size.width, finalHeight);
    // self.frame                          =   CGRectMake(0, self.controller.view.frame.size.height-kKeyBoardHeight-finalHeight, self.controller.view.frame.size.width, finalHeight);
}*/

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Type here"]) {
        textView.textColor              =   [self color_active];
        textView.text                   =   nil;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self actionSave:nil];
        return NO;
    } return YES;
}

#pragma mark    -   Find Height:

- (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGFloat result = font.pointSize + 4;
    if (text) {
        CGSize textSize = { widthValue, CGFLOAT_MAX };
        CGSize size;
        CGRect frame = [text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height+1);
        result = MAX(size.height, result); //At least one row
    }
    return result;
}

#pragma mark    -   Colours:

- (UIColor *)color_active {
    return [UIColor colorWithRed:(50/255.0) green:(61/255.0) blue:(77/255.0) alpha:1.0];
}

#pragma mark    -   Action Save:

- (IBAction)actionSave:(UIButton *)sender {
    [self.textView resignFirstResponder];
    self.textView.textColor         =   [[self color_active] colorWithAlphaComponent:0.4];
    [self dismissGrowingTextView];
    self.callback(self.textView.text);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
