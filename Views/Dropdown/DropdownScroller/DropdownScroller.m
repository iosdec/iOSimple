//
//  DropdownScroller.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "DropdownScroller.h"
#import "CGExt.h"

@implementation DropdownScroller {
    DropdownCell *lastView;
}

- (void)reloadWithItems:(NSArray *)items {
    
    [self clearWithClass:[DropdownCell class] sv:self completion:^{
        
        self->lastView                    =   nil;
        [self setContentSize:CGSizeMake(0, 0)];
        for (NSString *item in items) {
            [self addCell:item];
        }
        
    }];
    
}

- (void)addCell:(NSString *)title {
    CGFloat origin_y            =   0;
    if (lastView) { origin_y    =   [CGeometry bottomPositionOfView:lastView]; }
    DropdownCell *cell          =   [[DropdownCell alloc] initWithValue:title];
    cell.frame                  =   CGRectMake(0, origin_y, self.frame.size.width, kDropdownCellHeight);
    
    //  check if already contained:
    NSArray *selected           =   [self pickedItems];
    if ([selected containsObject:title]) {
        [cell check:YES];
    }
    
    lastView                    =   cell;
    [self addSubview:cell];
    [self setContentSize:CGSizeMake(0, [CGeometry bottomPositionOfView:cell])];
}

- (NSArray *)pickedItems {
    NSMutableArray *items       =   [[NSMutableArray alloc] init];
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[DropdownCell class]]) {
            DropdownCell *cell  =   (DropdownCell *)obj;
            if (cell.isChecked) {
                [items addObject:cell.titleLabel.text];
            }
        }
    }
    return items;
}

#pragma mark    -   Clear Contents:

- (void)clearWithClass:(Class)class sv:(UIScrollView *)sv completion:(void(^)(void))completion {
    
    NSArray *subviews           =   sv.subviews;
    
    if (class) {
        NSPredicate *predicate  =   [NSPredicate predicateWithFormat:@"self isKindOfClass: %@",class];
        subviews                =   [sv.subviews filteredArrayUsingPredicate:predicate];
    }
    
    if (!subviews) { completion(); return; }
    if (subviews.count == 0) { completion(); return; }
    NSUInteger current      =   0;
    for (id obj in subviews) {
        current++;
        [UIView animateWithDuration:0.4 animations:^{
            [obj setAlpha:0];
        } completion:^(BOOL finished) {
            [obj removeFromSuperview];
            if (current == subviews.count) {
                completion();
            }
        }];
    }
    
}

@end
