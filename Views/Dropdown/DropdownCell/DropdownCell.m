//
//  DropdownCell.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "DropdownCell.h"
#import "iOSimple+UIView.h"
#import "DropdownContainer.h"
#import "iOSimple+UIColour.h"

@implementation DropdownCell {
    UIColor *original_colour;
}

- (id)initWithValue:(NSString *)value {
    self = [super init];
    if (self) {
        DropdownCell *cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
        cell.value = value;
        [cell setupCell];
        self = cell;
    } return self;
}

- (void)setupCell {
    
    if (!self.value) { return; }
    
    original_colour = self.checkedContainer.backgroundColor;
    [self.titleLabel setText:self.value];
    [self addAction];
    
    if ([self.value isEqualToString:@"Chiropractor"]) {
        self.icon.image                     =   [UIImage imageNamed:@"cat_chrio_white.png"];
        self.imgContainer.backgroundColor   =   [[UIColor greenColor] colorWithAlphaComponent:0.7];
    }
    if ([self.value isEqualToString:@"Physical Therapist"]) {
        self.icon.image                     =   [UIImage imageNamed:@"cat_physical_therapist_white.png"];
        self.imgContainer.backgroundColor   =   [UIColor colourFromHexString:@"#6f8fbf"];
    }
    if ([self.value isEqualToString:@"Massage"]) {
        self.icon.image                     =   [UIImage imageNamed:@"cat_massage_white.png"];
        self.imgContainer.backgroundColor   =   [UIColor colourFromHexString:@"#bfb26f"];
    }
    if ([self.value isEqualToString:@"Accupuncture"]) {
        self.icon.image                     =   [UIImage imageNamed:@"cat_accu_white.png"];
        self.imgContainer.backgroundColor   =   [UIColor colourFromHexString:@"#bf6f6f"];
    }
    if ([self.value isEqualToString:@"Dietician"]) {
        self.icon.image                     =   [UIImage imageNamed:@"cat_diet_white.png"];
        self.imgContainer.backgroundColor   =   [UIColor colourFromHexString:@"#b46fbf"];
    }
    if ([self.value isEqualToString:@"Naturopathic Doctor"]) {
        self.icon.image                     =   [UIImage imageNamed:@"cat_np_doctor_white.png"];
        self.imgContainer.backgroundColor   =   [UIColor colourFromHexString:@"#6fb5bf"];
    }
    if ([self.value isEqualToString:@"Athletic Trainer"]) {
        self.icon.image                     =   [UIImage imageNamed:@"cat_trainer_white.png"];
        self.imgContainer.backgroundColor   =   [UIColor colourFromHexString:@"#75bf6f"];
    }
    
}

- (void)addAction {
    [self addMagicButtonWithAction:@selector(cellAction) sender:self];
}

- (void)cellAction {
    if (self.isChecked) {
        [self check:NO];
    } else {
        [self check:YES];
    }
}

#pragma mark    -   Action Check:

- (void)check:(BOOL)checked {
    
    [UIView transitionWithView:self.checkedContainer duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        if (checked) {
            [self.checkedContainer setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
            [self.checkedImage setAlpha:1];
        }
        
        else {
            [self.checkedContainer setBackgroundColor:self->original_colour];
            [self.checkedImage setAlpha:0];
        }
        
    } completion:^(BOOL finished) {
        
        DropdownContainer *container = (DropdownContainer *)self.superview.superview;
        [container updateTitle];
        
    }];
    
    self.isChecked      =   checked;
    
}

@end
