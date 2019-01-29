//
//  IBPickerItem.m
//  SuperbiOS
//
//  Created by R3V0 on 19/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import "IBPickerItem.h"
#import "iOSimple.h"
#import "IBPickerContainer.h"

#define BabyBlue [UIColor colorWithRed:(38/255.0) green:(132/255.0) blue:(255/255.0) alpha:0.7]

@implementation IBPickerItem

#pragma mark    -   Lifecycle:

- (id)initWithTitle:(NSString *)title picker:(IBPickerView *)picker {
    
    self        =   [super init];
    
    if (self) {
        
        IBPickerItem *item = [XIBInit xibWithClass:[self class]];
        
        if (title) {
            item.title = title;
        }
        
        if (picker) {
            item.picker = picker;
        }
        
        [item setupView];
        self = item;
        
    }
    
    return self;
    
}

#pragma mark    -   Setup view:

- (void)setupView {
    
    [self setupButton];
    
    if (!self.title && !self.picker) { return; }
    
    self.titleLabel.text        =   self.title;
    self.titleLabel.font        =   self.picker.titleLabel.font;
    
}

#pragma mark    -   Button Stuff:

- (void)setupButton {
    
    UIButton *button            =   [[UIButton alloc] init];
    button.frame                =   CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [button setResizingMask:MaskTypeFull];
    
    [button addTarget:self action:@selector(buttonAction_touchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(buttonAction_touchCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragExit | UIControlEventTouchDragEnter | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside];
    [button addTarget:self action:@selector(buttonAction_touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    
}

- (void)buttonAction_touchDown:(UIButton *)button {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self setBackgroundColor:BabyBlue];
        
    }];
    
}

- (void)buttonAction_touchCancel:(UIButton *)button {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
    }];
    
}

- (void)buttonAction_touchUpInside:(UIButton *)button {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        IBPickerContainer *container    =   (IBPickerContainer *)self.superview;
        [container.pickerView itemPicker:self];
        
    }];
    
}

@end
