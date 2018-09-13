//
//  DropdownScroller.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropdownCell.h"

@interface DropdownScroller : UIScrollView

- (void)reloadWithItems:(NSArray *)items;

- (NSArray *)pickedItems;

@end
