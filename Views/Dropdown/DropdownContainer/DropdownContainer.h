//
//  DropdownContainer.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropdownView.h"

#define kNO_DropdownContainerClose @"kNO_DropdownContainerClose"

@interface DropdownContainer : UIView

- (id)initFromXIB:(DropdownView *)view;
- (void)updateTitle;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) DropdownView *view;

@end
