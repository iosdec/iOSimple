//
//  SUPicker.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "SUPicker.h"
#import "CGExt.h"
#import "Finder.h"
#import "iOSimple+UIView.h"
#import <QuartzCore/QuartzCore.h>

@interface SUPicker() <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSString *pickedString;
    NSDate *pickedDate;
}
@end

@implementation SUPicker

+ (id)pickerWithData:(NSArray<NSString *> *)data {
    
    SUPicker *picker    =   [XIBInit xibWithClass:[self class]];
    
    if (data) {
        [picker setData:data];
    }
    
    [picker setup];
    return picker;
    
}


+ (id)pickerWithType:(SUPickerType)type previousDate:(NSDate *)date {
    
    SUPicker *picker    =   [XIBInit xibWithClass:[self class] index:1];
    picker.type         =   type;
    
    if (type == SUPickerTypeDate) {
        picker.customDatePicker.datePickerMode = UIDatePickerModeDate;
    }
    if (type == SUPickerTypeTime) {
        picker.customDatePicker.datePickerMode = UIDatePickerModeTime;
    }
    if (type == SUPickerTypeDateTime) {
        picker.customDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    
    [picker setupDatePicker];
    return picker;
    
}

#pragma mark        -   Setup:

- (void)setup {
    
    if (!self.data) { return; }
    
    [self setBlurView:[self createBlurView]];
    [self.customPicker setDelegate:self];
    [self.customPicker setDataSource:self];
    [self.customPicker reloadAllComponents];
    [self.layer setZPosition:MAXFLOAT];
    
    //  preset default value:
    if (self.data.count != 0) {
        NSString *firstItem     =   [self.data firstObject];
        self->pickedString      =   firstItem;
    }
    
}

- (void)setupDatePicker {
    [self setBlurView:[self createBlurView]];
    [self.customDatePicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
}

- (UIView *)createBlurView {
    UIView *view            =   [[UIView alloc] init];
    UIView *container       =   [[Finder findTopViewController] view];
    [view sameRectWithView:container];
    [view setResizingMask:MaskTypeFull];
    [view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    [view setAlpha:0];
    return view;
}

#pragma mark    -   Set Text:

- (void)setTitle:(NSString *)text {
    [self.titleLabel setText:text];
}
- (void)setMessage:(NSString *)message {
    [self.messageLabel setText:message];
}





#pragma mark    -   Picker View Data Source:

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (!self.data) { return 0; }
    return self.data.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    if (!self.data) { return nil; }
    if ((self.data.count < 1) > row) { return nil; }
    NSString *title = self.data[row];
    
    UILabel *label              =   [[UILabel alloc] init];
    label.text                  =   title;
    label.font                  =   [UIFont systemFontOfSize:16];
    label.textAlignment         =   NSTextAlignmentCenter;
    label.textColor             =   [UIColor blackColor];
    label.autoresizingMask      =   UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    return label;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (!self.data) { return; }
    if ((self.data.count < 1) > row) { return; }
    NSString *title = self.data[row];
    
    if (title) {
        self->pickedString = title;
    }
    
}

#pragma mark    -   Date Picker Action:

- (void)datePickerAction:(UIDatePicker *)picker {
    
}





#pragma mark    -   Actions:

- (IBAction)actionSelect:(UIButton *)sender {
    [self dismiss:^{
        if (self.completion) {
            
            //  if normal picker:
            if (self.type == SUPickerTypeNone) {
                if (self->pickedString) {
                    self.completion(self->pickedString);
                } else {
                    self.completion(nil);
                } return;
            }
            
            //  if date picker:
            if (self.type != SUPickerTypeNone) {
                self.completion(self.customDatePicker.date);
            }
            
        }
    }];
}

- (IBAction)actionCancel:(UIButton *)sender {
    self->pickedString              =   nil;
    [self dismiss:^{
    }];
}












#pragma mark    -   Presentation:

- (void)presentAtBottom:(void(^)(id item))completion {
    
    if (completion) {
        [self setCompletion:completion];
    }
    
    //  container will be the top view controller. so lets fetch:
    UIView *containerView   =   [[Finder findTopViewController] view];
    self.container          =   containerView;
    
    //  add blur view:
    [containerView addSubview:self.blurView];
    
    //  add to container:
    [self setFrame:CGRectMake((containerView.frame.size.width / 2) - (SUPickerWidth / 2), containerView.frame.size.height, SUPickerWidth, SUPickerHeight)];
    [containerView addSubview:self];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.blurView setAlpha:1];
        [self setCenter:containerView.center];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)presentInMiddle:(void(^)(id item))completion {
    
    if (completion) {
        [self setCompletion:completion];
    }
    
    //  container will be the top view controller. so lets fetch:
    UIView *containerView   =   [[Finder findTopViewController] view];
    self.container          =   containerView;
    
    //  add blur view:
    [containerView addSubview:self.blurView];
    
    //  add to container:
    [self setFrame:CGRectMake((containerView.frame.size.width / 2) - (SUPickerWidth / 2), containerView.frame.size.height, SUPickerWidth, SUPickerHeight)];
    [containerView addSubview:self];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.blurView setAlpha:1];
        [self setCenter:containerView.center];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)presentAtPoint:(CGPoint)point container:(UIView *)container action:(void (^)(id item))completion {
    
    if (completion) {
        [self setCompletion:completion];
    }
    
}

#pragma mark    -   Dismiss:

- (void)dismiss:(void(^)(void))completion {
    
    UIView *view        =   [[Finder findTopViewController] view];
    
    if (self.container) {
        view = self.container;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self sameRectWithNewY:view.frame.size.height];
        [self.blurView setAlpha:0];
        
    } completion:^(BOOL finished) {
        
        [self.blurView removeFromSuperview];
        [self removeFromSuperview];
        
        if (completion) {
            completion();
        }
        
    }];
    
}

@end
