//
//  IBPickerView.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land.
//

#import "IBPickerView.h"

#import "iOSimple.h"
#import "IBPickerContainer.h"

@implementation IBPickerView {
    
    IBPickerContainer *container;   //  container view.
    
}

#pragma mark    -   Lifecycle:

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.alreadySetup) {
        [self setupView];
        self.alreadySetup = YES;
    }
}

#pragma mark    -   Setup:

- (void)setupView {
    
    self.layer.cornerRadius         =   self.cornerRadius;
    
    if (self.borderColour) {
        self.layer.borderColor      =   self.borderColour.CGColor;
        self.layer.borderWidth      =   self.borderWidth;
    }
    
    if (self.rightImage) {
        self.rightImageView.image   =   self.rightImage;
        self.rightImageView.alpha   =   self.rightImageOpacity;
    }
    
    if (!self.rightImage) {
        self.rightImageView.alpha   =   0;
        self.titleLabel.frame       =   CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.frame.size.width - (self.titleLabel.frame.origin.x * 2), self.titleLabel.frame.size.height);
    }
    
    if (self.placeholder) {
        self.titleLabel.text        =   self.placeholder;
    }
    
    //  data source:
    if (self.stringDataSource) {
        if (self.stringDataSource.length != 0 && [self.stringDataSource containsString:@","]) {
            NSArray *items          =   [self.stringDataSource componentsSeparatedByString:@","];
            if (items.count != 0) {
                self.dataSource     =   items;
            }
        }
    }
    
    //  get controller:
    UIViewController *controller    =   [Finder findControllerWithObject:self];
    
    if (controller) {
        
        //  check for string selector:
        if (self.callbackString) {
            SEL selector = NSSelectorFromString(self.callbackString);
            if ([controller respondsToSelector:selector]) {
                self.callbackSelector   =   selector;
            }
        }
        
        self.sender                 =   controller;
        
    }
    
    //  button:
    [self setupButton];
    
}

#pragma mark    -   Button Stuff:

- (void)setupButton {
    
    UIButton *button                =   [[UIButton alloc] init];
    button.frame                    =   CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [button setResizingMask:MaskTypeFull];
    
    [button addTarget:self action:@selector(buttonAction_touchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(buttonAction_touchCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragExit | UIControlEventTouchDragEnter | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside];
    [button addTarget:self action:@selector(buttonAction_touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *firstButton           =   [self firstButtonInIndex];
    
    if (firstButton) {
        [self insertSubview:button belowSubview:firstButton];
    } else {
        [self addSubview:button];
    }
    
}

- (void)buttonAction_touchDown:(UIButton *)button {
    [UIView animateWithDuration:0.3 animations:^{
        self.titleLabel.alpha = 0.4;
    }];
}

- (void)buttonAction_touchCancel:(UIButton *)button {
    [UIView animateWithDuration:0.3 animations:^{
        self.titleLabel.alpha = 1;
    }];
}

- (void)buttonAction_touchUpInside:(UIButton *)button {
    [UIView animateWithDuration:0.3 animations:^{
        self.titleLabel.alpha = 1;
    } completion:^(BOOL finished) {
        if (!self.isActive) {
            [self setActive:YES];
        } else {
            [self setActive:NO];
        }
    }];
}

#pragma mark    -   Set Active:

- (void)setActive:(BOOL)active {
    
    if (active) {
        [self presentContainer];
    }
    
    else {
        [self removeContainer];
    }
    
    self.isActive = active;
    
}

#pragma mark    -   Remove Other Instances:

- (void)removeOtherInstances {
    
    if (!self.sender) { return; }
    if (![self.sender isKindOfClass:[UIViewController class]]) { return; }
    
    UIViewController *controller = (UIViewController *)self.sender;
    
    for (id obj in controller.view.subviews) {
        
        if ([obj isKindOfClass:[IBPickerContainer class]]) {
            IBPickerContainer *container    =   (IBPickerContainer *)obj;
            [container.pickerView removeContainer];
        }
        
    }
    
}

- (void)itemPicker:(IBPickerItem *)item {
    
    if (item.title) {
        self.titleLabel.text = item.title;
    }
    
    [self removeContainer];
    
}

#pragma mark    -   Present Container:

- (void)presentContainer {
    
    if (!self.sender) { return; }
    if (![self.sender isKindOfClass:[UIViewController class]]) { return; }
    
    UIViewController *vc        =   (UIViewController *)self.sender;
    CGFloat height              =   self.frame.size.height * 5;
    CGFloat origin_y            =   self.superview.frame.origin.x + self.frame.origin.y + self.frame.size.height + 16;
    CGFloat origin_x            =   self.superview.frame.origin.x + self.frame.origin.x;;
    
    [self removeOtherInstances];
    
    if (!self->container) {
        self->container         =   [[IBPickerContainer alloc] initWithPicker:self];
        self->container.frame   =   CGRectMake(origin_x, origin_y, self.frame.size.width, height);
        self->container.alpha   =   0;
        [self->container setClipsToBounds:YES];
        [self->container reloadWithContents:self.dataSource];
        [vc.view addSubview:self->container];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        //  check for flip:
        if (self.flipImageWhenActive) {
            self.rightImageView.transform = CGAffineTransformMakeRotation(180 * M_PI/180);
        }
        
        self->container.alpha   =   1;
        
    }];
    
}

- (void)removeContainer {
    
    if (!self->container) { return; }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self->container.alpha       =   0;
        
        //  check for flip:
        if (self.flipImageWhenActive) {
            self.rightImageView.transform = CGAffineTransformMakeRotation(0 * M_PI/180);
        }
        
    } completion:^(BOOL finished) {
        
        [self->container removeFromSuperview];
        self->container = nil;
        self.isActive = NO;
        
    }];
    
}

@end
