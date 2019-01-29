//
//  IBPickerContainer.h
//  iOSDec
//
//  Created by Declan Land.
//  Copyright Declan Land.
//

#import <UIKit/UIKit.h>

#import "IBPickerView.h"
#import "IBPickerItem.h"

/*!
 @brief Contains IBPickerItems.
*/
@interface IBPickerContainer : UIScrollView

/*!
 @brief Create view with IBPickerView options.
*/
- (id)initWithPicker:(IBPickerView *)pickerView;

/*!
 @brief Clear and add items to container.
*/
- (void)reloadWithContents:(NSArray <NSString *> *)contents;

/*!
 @brief Stored data.
*/
@property (strong, nonatomic) NSArray <NSString *> *contents;

/*!
 @brief Stored picker view.
*/
@property (strong, nonatomic) IBPickerView *pickerView;

@end
