//
//  DropdownContainer.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "DropdownContainer.h"
#import "DropdownScroller.h"
#import "DropdownCell.h"

@implementation DropdownContainer

- (id)initFromXIB:(DropdownView *)view {
    self = [super init];
    if (self) {
        DropdownContainer *container = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
        container.view = view;
        self = container;
    } return self;
}

- (void)updateTitle {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[DropdownScroller class]]) {
            DropdownScroller *scroller = (DropdownScroller *)obj;
            [self cycleThroughScroller:scroller];
        }
    }
}

- (void)cycleThroughScroller:(DropdownScroller *)scroller {
    
    NSString *master_string = @"-";
    for (id obj in scroller.subviews) {
        if ([obj isKindOfClass:[DropdownCell class]]) {
            DropdownCell *cell = (DropdownCell *)obj;
            if (cell.isChecked) {
                if ([master_string isEqualToString:@"-"]) {
                    master_string = cell.value;
                } else {
                    master_string = [master_string stringByAppendingString:[NSString stringWithFormat:@", %@", cell.value]];
                }
            }
        }
    }
    
    [self.titleLabel setText:master_string];
    [self.view setText:master_string];
    
}

- (IBAction)actionClose:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNO_DropdownContainerClose object:self];
}

@end
