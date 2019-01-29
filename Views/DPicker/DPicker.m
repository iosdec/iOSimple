//
//  DPicker.m
//  SuperbiOS
//
//  Created by R3V0 on 09/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import "DPicker.h"
#import "Finder.h"
#import "iOSimple+UIView.h"

@interface DPicker() {
    
    CGPoint relativeOrigin; //  relative point origin.
    
}
@end

@implementation DPicker

#pragma mark    -   Presentation:

+ (void)presentWithType:(DPickerType)type previous:(NSDate *)previous source:(id)source completion:(void(^)(NSDate *pickedDate))completion {
    
    DPicker *picker     =   [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
    picker.type         =   type;
    
    if (source) {
        picker.source   =   source;
    }
    
    if (completion) {
        [picker setCompletion:completion];
    }
    
    //  previous date:
    if (previous) {
        picker.pickerView.date = previous;
    }
    
    //  check source:
    if (!source) { return; }
    
    UIView *sourceView              =   (UIView *)source;
    UIViewController *controller    =   [Finder findControllerWithObject:source];
    UIView *controllerView          =   controller.view;
    
    //  first.. check for other instances:
    [picker removeOtherInstances:controller];
    
    //  #   Present:
    picker.frame        =   [picker calculatedRect:sourceView];
    picker.alpha        =   0;
    
    //  #   Create Blur View:
    
    UIView *blurView    =   [picker preBlurView];
    picker.blurView     =   blurView;
    [picker setupView];
    
    //  #   Insert:
    if (!controller) { return; }
    [controllerView addSubview:picker.blurView];
    [controllerView addSubview:picker];
    
    [UIView animateWithDuration:0.3 animations:^{
        picker.blurView.alpha   =   1;
        picker.alpha            =   1;
    }];
    
}

+ (void)presentWithType:(DPickerType)type container:(UIView *)container position:(CGPoint)position completion:(void (^)(NSDate *))completion {
    
    DPicker *picker     =   [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
    [picker setBackgroundColor:[UIColor whiteColor]];
    picker.type         =   type;
    
    [picker drawTriangleWithWidth:10 up:YES];
    
    if (completion) {
        [picker setCompletion:completion];
    }
    
    //  first.. check for other instances:
    [picker removeOtherInstancesWithView:container];
    
    //  #   Present:
    picker.frame        =   CGRectMake(position.x, position.y, DPickerWidth, DPickerHeight);
    picker.alpha        =   0;
    
    //  #   Create Blur View:
    
    UIView *blurView    =   [picker preBlurView];
    picker.blurView     =   blurView;
    [picker setupView];
    
    //  #   Insert:
    [container addSubview:picker.blurView];
    [container addSubview:picker];
    
    [UIView animateWithDuration:0.3 animations:^{
        picker.blurView.alpha   =   1;
        picker.alpha            =   1;
    }];
    
}
























+ (void)presentWithData:(NSArray<NSString *> *)data source:(id)source completion:(void (^)(NSString *))completion {
    
    DPicker *picker     =   [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][1];
    picker.dataType     =   DPickerDataTypeCustom;
    
    if (data) {
        if (data.count != 0) {
            picker.storedDataSource = data;
            picker.pickedObject = data[0];
        }
    }
    
    if (source) {
        picker.source   =   source;
    }
    
    if (completion) {
        [picker setPickerCustomCompletion:completion];
    }
    
    //  #   Check source:
    
    if (!source) { return; }
    
    UIView *sourceView              =   (UIView *)source;
    UIViewController *controller    =   [Finder findControllerWithObject:source];
    UIView *controllerView          =   controller.view;
    
    //  first.. check for other instances:
    [picker removeOtherInstances:controller];
    
    //  #   Present:
    picker.frame        =   [picker calculatedRect:sourceView];
    picker.alpha        =   0;
    
    //  #   Create Blur View:
    
    UIView *blurView    =   [picker preBlurView];
    picker.blurView     =   blurView;
    [picker setupView];
    
    //  #   Insert:
    if (!controller) { return; }
    [controllerView addSubview:picker.blurView];
    [controllerView addSubview:picker];
    
    [UIView animateWithDuration:0.3 animations:^{
        picker.blurView.alpha   =   1;
        picker.alpha            =   1;
    }];
    
}

+ (void)presentWithData:(NSArray<NSString *> *)data container:(UIView *)container position:(CGPoint)position completion:(void (^)(NSString *))completion {
    
    DPicker *picker     =   [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][1];
    picker.dataType     =   DPickerDataTypeCustom;
    
    if (data) {
        if (data.count != 0) {
            picker.storedDataSource = data;
            picker.pickedObject = data[0];
        }
    }
    
    if (completion) {
        [picker setPickerCustomCompletion:completion];
    }
    
    //  first.. check for other instances:
    [picker removeOtherInstancesWithView:container];
    
    //  present:
    CGRect frame        =   CGRectMake(position.x, position.y, DPickerWidth, DPickerHeight);
    picker.frame        =   frame;
    picker.alpha        =   0;
    
    //  #   Create Blur View:
    
    UIView *blurView    =   [picker preBlurView];
    picker.blurView     =   blurView;
    [picker setupView];
    
    //  #   Insert:
    [container addSubview:picker.blurView];
    [container addSubview:picker];
    
    [UIView animateWithDuration:0.3 animations:^{
        picker.blurView.alpha   =   1;
        picker.alpha            =   1;
    }];
    
}










#pragma mark    -   Custom Data.

+ (void)presentWithData:(NSArray <NSString *> *)data controller:(UIViewController *)controller completion:(void(^)(NSString *pickedObject))completion {
    
    DPicker *picker     =   [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][1];
    picker.dataType     =   DPickerDataTypeCustom;
    
    if (data) {
        if (data.count != 0) {
            picker.storedDataSource = data;
            picker.pickedObject = data[0];
        }
    }
    
    if (completion) {
        [picker setPickerCustomCompletion:completion];
    }
    
    UIView *controllerView          =   controller.view;
    
    //  first.. check for other instances:
    [picker removeOtherInstances:controller];
    
    //  #   Present:
    picker.frame        =   [picker calculatedRect:[UIView new]];
    picker.center       =   controllerView.center;
    picker.alpha        =   0;
    
    //  #   Create Blur View:
    
    UIView *blurView                    =   [picker preBlurView];
    picker.blurView                     =   blurView;
    picker.blurView.backgroundColor     =   [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [picker setupView];
    
    //  #   Insert:
    if (!controller) { return; }
    [controllerView addSubview:picker.blurView];
    [controllerView addSubview:picker];
    
    [UIView animateWithDuration:0.3 animations:^{
        picker.blurView.alpha   =   1;
        picker.alpha            =   1;
    }];
    
}

#pragma mark    -   Automatic Rect:

- (CGRect)calculatedRect:(UIView *)sourceView {
    
    CGFloat picker_x            =   (sourceView.frame.size.width / 2) - (DPickerWidth / 2) - (sourceView.frame.size.width / 2);
    CGFloat width               =   DPickerWidth;
    CGFloat height              =   DPickerHeight;
    UIView *topView             =   sourceView;
    CGFloat calc_x              =   sourceView.frame.origin.x;
    CGFloat calc_y              =   sourceView.frame.origin.y;
    
    while (topView) {
        
        if (CGRectEqualToRect(topView.frame, UIScreen.mainScreen.bounds)) {
            break;
        }
        
        else {
            topView = topView.superview;
            calc_x += topView.frame.origin.x;
            calc_y += topView.frame.origin.y;
        }
        
    }
    
    return CGRectMake(calc_x + picker_x, calc_y + sourceView.frame.size.height + 16, width, height);
    
}

#pragma mark    -   Setup View:

- (void)setupView {
    
    //  #   Add Shadow:
    
    self.layer.masksToBounds            =   NO;
    self.layer.shadowRadius             =   20;
    self.layer.shadowOpacity            =   0.4;
    self.layer.shadowOffset             =   CGSizeMake(0, 0);
    self.layer.shadowColor              =   [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
    
    //  #   Check type:
    
    if (self.dataType == DPickerDataTypeDate) {
        
        if (self.type == DPickerTypeDate) {
            [self.pickerView setDatePickerMode:UIDatePickerModeDate];
        }
        if (self.type == DPickerTypeTime) {
            [self.pickerView setDatePickerMode:UIDatePickerModeTime];
        }
        if (self.type == DPickerTypeDateAndTime) {
            [self.pickerView setDatePickerMode:UIDatePickerModeDateAndTime];
        }
        
    }
    
    if (self.dataType == DPickerDataTypeCustom) {
        
        if (self.storedDataSource) {
            
            if (self.storedDataSource.count != 0) {
                
                [self.customPickerView setDelegate:self];
                [self.customPickerView setDataSource:self];
                
            }
            
        }
        
    }
    
    //  #   Draw Triangle:
    
    if (self.source) {
        [self drawTriangleWithWidth:10 up:YES];
    }
    
}

- (UIView *)preBlurView {
    
    UIView *blurView                    =   [[UIView alloc] init];
    blurView.frame                      =   CGRectMake(0, 0, self.controller.view.frame.size.width, self.controller.view.frame.size.height);
    blurView.backgroundColor            =   [[UIColor blackColor] colorWithAlphaComponent:0.3];
    blurView.alpha                      =   0;
    [blurView setResizingMask:MaskTypeFull];
    return blurView;
    
}

- (void)drawTriangleWithWidth:(CGFloat)width up:(BOOL)up {
    
    CAShapeLayer *layer         =   [[CAShapeLayer alloc] init];
    UIBezierPath *path          =   [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    
    if (up) {
        [path moveToPoint:CGPointMake((self.frame.size.width / 2) - (width / 2), 0)];
        [path addLineToPoint:CGPointMake(self.frame.size.width / 2 - (width / 2), 0)];
        [path addLineToPoint:CGPointMake(self.frame.size.width / 2, -width)];
        [path addLineToPoint:CGPointMake((self.frame.size.width / 2) + (width / 2), 0)];
        [path closePath];
        [layer setFrame:self.bounds];
        [layer setPath:path.CGPath];
        [layer setFillColor:self.backgroundColor.CGColor];
        [self setClipsToBounds:NO];
        [self.layer addSublayer:layer];
    }
    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.blurView.alpha =   0;
        self.alpha          =   0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        if (self.completion) {
            
            if (self.pickedDate) {
                self.completion(self.pickedDate);
            } else {
                self.completion(nil);
            }
            
        }
        
        if (self.pickerCustomCompletion) {
            
            if (self.pickedObject) {
                self.pickerCustomCompletion(self.pickedObject);
            } else {
                self.pickerCustomCompletion(nil);
            }
            
        }
        
    }];
    
}

#pragma mark    -   Custom Picker:

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (!self.storedDataSource) { return nil; }
    
    if (self.storedDataSource.count == 0) { return nil; }
    
    if (self.storedDataSource.count - 1 < row) { return nil; }
    
    NSString *item = self.storedDataSource[row];
    
    return item;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (!self.storedDataSource) { return; }
    
    if (self.storedDataSource.count == 0) { return; }
    
    if (self.storedDataSource.count - 1 < row) { return; }
    
    NSString *item = self.storedDataSource[row];
    
    self.pickedObject = item;
    
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (!self.storedDataSource) { return 0; }
    
    return self.storedDataSource.count;
    
}

#pragma mark    -   Remove Other Instances:

- (void)removeOtherInstances:(UIViewController *)controller {
    for (id obj in controller.view.subviews) {
        if ([obj isKindOfClass:[DPicker class]]) {
            DPicker *picker = (DPicker *)obj;
            picker.pickedObject = nil;
            picker.pickedDate = nil;
            [picker dismiss];
        }
    }
}

- (void)removeOtherInstancesWithView:(UIView *)view {
    for (id obj in view.subviews) {
        if ([obj isKindOfClass:[DPicker class]]) {
            DPicker *picker = (DPicker *)obj;
            picker.pickedObject = nil;
            picker.pickedDate = nil;
            [picker dismiss];
        }
    }
}

#pragma mark    -   Action Cancel:

- (IBAction)actionCancel:(UIButton *)sender {
    
    self.pickedDate     =   nil;
    self.pickedObject   =   nil;
    [self dismiss];
    
}

#pragma mark    -   Action Done:

- (IBAction)actionDone:(UIButton *)sender {
    
    if (self.pickerView.date) {
        self.pickedDate = self.pickerView.date;
    }
    
    [self dismiss];
    
}

@end
