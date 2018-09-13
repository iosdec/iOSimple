//
//  DropdownView.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "DropdownView.h"
#import "iOSimple+UIView.h"
#import "Finder.h"
#import "CGExt.h"
#import "Validator.h"
#import "iOSimple+UIColour.h"
#import "DropdownScroller.h"
#import "DropdownContainer.h"

#define kContainerHeight 300
#define kPickerHeight 262

@implementation DropdownView {
    UIDatePicker            *_datePicker;
    DropdownContainer       *_pickerContainer;
    UIViewController        *_controller;
    DropdownScroller        *_scroller;
    UIView                  *_darkview;
}

- (void)layoutSubviews {
    if (!self.alreadySetup) {
        [self setupDropdownView];
        self.alreadySetup = YES;
    }
}
- (void)setupDropdownView {
    
    //  border:
    self.layer.borderColor          =   [UIColor colourFromHexString:@"#232323"].CGColor;
    self.layer.borderWidth          =   0.7;
    
    //  find controller:
    UIViewController *controller    =   [Finder findControllerWithObject:self];
    if (controller) { _controller = controller; }
    
    //  add magic button:
    [self addMagicButtonWithAction:@selector(presentDropdown) sender:self];
    
    //  add close handler:
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeContainer) name:kNO_DropdownContainerClose object:nil];
    
}

- (void)show:(UIViewController *)controller {
    _controller = controller;
    [self presentDropdown];
}
- (void)hide {
    [self closeContainer];
}

- (void)presentDropdown {
    
    if (self.date) {
        [self presentDatePicker];
        return;
    }
    
    if (!self.items) {
        // NSLog(@"you havent supplied items");
        return;
    }
    
    [self presentItemsPicker];
    
}

- (void)closeContainer {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_darkview setAlpha:0];
        [self->_pickerContainer sameRectWithNewY:self->_controller.view.frame.size.height];
    } completion:^(BOOL finished) {
        [self->_pickerContainer removeFromSuperview];
        [self->_darkview removeFromSuperview];
        self->_darkview = nil;
        self->_pickerContainer = nil;
    }];
}

- (void)setupContainer {
    _pickerContainer                    =   [[DropdownContainer alloc] initFromXIB:self];
    _pickerContainer.frame              =   CGRectMake(0, _controller.view.frame.size.height, _controller.view.frame.size.width, kContainerHeight);
}

- (void)setupDatePicker {
    _datePicker                 =   [[UIDatePicker alloc] init];
    _datePicker.frame           =   CGRectMake(0, [CGeometry bottomPositionOfView:_pickerContainer.titleLabel] + 8, _pickerContainer.frame.size.width, kPickerHeight);
    _datePicker.datePickerMode  =   UIDatePickerModeDate;
    [_datePicker setResizingMask:MaskTypeFull];
    [_datePicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)setupPicker {
    _scroller                   =   [[DropdownScroller alloc] init];
    _scroller.frame             =   CGRectMake(0, [CGeometry bottomPositionOfView:_pickerContainer.titleLabel] + 8, _pickerContainer.frame.size.width, kPickerHeight);
}

- (void)setupDarkView {
    _darkview                   =   [[UIView alloc] init];
    UIViewController *cont      =   [Finder findControllerWithObject:self];
    _darkview.frame             =   CGRectMake(0, 0, cont.view.frame.size.width, cont.view.frame.size.height);
    [_darkview setResizingMask:MaskTypeFull];
    [_darkview setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
    [_darkview setAlpha:0];
}

#pragma mark    -   Present Date Picker:

- (void)presentDatePicker {
    
    //  setup dark view:
    if (!_darkview) {
        [self setupDarkView];
    }
    
    //  setup container:
    if (!_pickerContainer) {
        [self setupContainer];
    }
    
    //  setup date picker:
    if (!_datePicker) {
        [self setupDatePicker];
    }
    
    //  add to view:
    [_pickerContainer addSubview:_datePicker];
    
    //  present on top controller:
    UIViewController *topcontroller     =   [Finder findTopViewController];
    
    if (![topcontroller.view.subviews containsObject:_darkview]) {
        [topcontroller.view addSubview:_darkview];
    }
    
    if (![topcontroller.view.subviews containsObject:_pickerContainer]) {
        [topcontroller.view addSubview:_pickerContainer];
    }
    
    //  animate in:
    [UIView animateWithDuration:0.3 animations:^{
        [self->_darkview setAlpha:1];
        [self->_pickerContainer sameRectWithNewY:self->_controller.view.frame.size.height - self->_pickerContainer.frame.size.height];
    }];
    
}

- (void)datePickerAction:(UIDatePicker *)picker {
    NSDate *picked_date     =   picker.date;
    self.pickedDate         =   picked_date;
    NSString *date_string   =   [Validator validateDateToString:picked_date withTime:NO pretty:YES];
    [self setText:date_string];
}

#pragma mark    -   Present Picker:

- (void)presentItemsPicker {
    
    //  setup dark view:
    if (!_darkview) {
        [self setupDarkView];
    }
    
    //  setup container:
    if (!_pickerContainer) {
        [self setupContainer];
    }
    
    //  setup picker:
    if (!_scroller) {
        [self setupPicker];
    }
    
    //  add to view:
    [_pickerContainer addSubview:_scroller];
    
    //  present on top controller:
    UIViewController *topcontroller     =   [Finder findTopViewController];
    
    if (![topcontroller.view.subviews containsObject:_darkview]) {
        [topcontroller.view addSubview:_darkview];
    }
    
    if (![topcontroller.view.subviews containsObject:_pickerContainer]) {
        [topcontroller.view addSubview:_pickerContainer];
    }
    
    //  animate in:
    [UIView animateWithDuration:0.3 animations:^{
        [self->_darkview setAlpha:1];
        [self->_pickerContainer sameRectWithNewY:self->_controller.view.frame.size.height - self->_pickerContainer.frame.size.height];
        [self->_scroller reloadWithItems:self.items];
    }];
    
}

#pragma mark    -   Action Methods:

- (void)setText:(NSString *)text {
    UILabel *titleLabel     =   [self titleLabel];
    if (!titleLabel) { return; }
    titleLabel.text         =   text;
}

#pragma mark    -   Getters:

- (UILabel *)titleLabel {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)obj;
            if (label.tag == 1) {
                return label;
            }
        }
    } return nil;
}

- (UIImageView *)dropdownImage {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView *image = (UIImageView *)obj;
            if (image.tag == 1) {
                return image;
            }
        }
    } return nil;
}

- (NSArray *)pickedItems {
    return _scroller.pickedItems;
}










@end
