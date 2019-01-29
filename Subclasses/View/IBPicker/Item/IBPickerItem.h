//
//  IBPickerItem.h
//  iOSDec
//
//  Created by Declan Land.
//  Copyright Decla Land.
//

#import <UIKit/UIKit.h>
#import "IBPickerView.h"

@class IBPickerView;

/*!
 @brief Item that will sit in the container; presented with IBPickerView.
*/
@interface IBPickerItem : UIView

/*!
 @brief Create view with title.
 @param title Title of the item.
 @param picker Picker instance - uses same settings for font, etc.
 @return id View instance from XIB.
*/
- (id)initWithTitle:(NSString *)title picker:(IBPickerView *)picker;

/*!
 @brief Stored title.
*/
@property (strong, nonatomic) NSString *title;

/*!
 @brief Stored picker.
*/
@property (strong, nonatomic) IBPickerView *picker;

#pragma mark    -   Outlets:

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
