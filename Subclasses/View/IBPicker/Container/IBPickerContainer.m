//
//  IBPickerContainer.m
//  iOSDec
//
//  Created by Declan Land.
//  Copyright Declan Land.
//

#import "IBPickerContainer.h"

#import "iOSimple.h"

@implementation IBPickerContainer {
    
    IBPickerItem        *lastView;
    
}

#pragma mark    -   Lifecycle:

- (id)initWithPicker:(IBPickerView *)pickerView {
    
    self            =   [super init];
    
    if (self) {
        
        if (pickerView) {
            self.pickerView = pickerView;
        }
        
        [self setupView];
        
    }
    
    return self;
    
}

#pragma mark    -   Setup view:

- (void)setupView {
    
    if (!self.pickerView) { return; }
    
    if (self.pickerView.borderColour) {
        self.layer.borderColor          =   self.pickerView.borderColour.CGColor;
        self.layer.borderWidth          =   self.pickerView.borderWidth;
    }
    
    self.layer.cornerRadius             =   self.pickerView.cornerRadius;
    self.backgroundColor                =   self.pickerView.backgroundColor;
    
    self.layer.masksToBounds            =   NO;
    self.layer.shadowRadius             =   20;
    self.layer.shadowOpacity            =   0.4;
    self.layer.shadowOffset             =   CGSizeMake(0, 0);
    self.layer.shadowColor              =   [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
    
}

#pragma mark    -   Reload:

- (void)reloadWithContents:(NSArray<NSString *> *)contents {
    
    [self setAlwaysBounceVertical:YES];
    
    [self clearWithClass:[IBPickerItem class] completion:^{
        
        self->lastView          =   nil;
        
        for (NSString *title in contents) {
            [self addItemWithTitle:title];
        }
        
    }];
    
}

#pragma mark    -   Add Item:

- (void)addItemWithTitle:(NSString *)title {
    
    CGFloat origin_y            =   12;
    
    if (self->lastView) {
        origin_y                =   self->lastView.frame.origin.y + self->lastView.frame.size.height + 8;
    }
    
    IBPickerItem *item          =   [[IBPickerItem alloc] initWithTitle:title picker:self.pickerView];
    item.frame                  =   CGRectMake(0, origin_y, self.frame.size.width, self.pickerView.frame.size.height - 8);
    self->lastView              =   item;
    
    [self addSubview:item];
    [self setContentSize:CGSizeMake(0, item.frame.origin.y + item.frame.size.height + 16)];
    
}

@end
