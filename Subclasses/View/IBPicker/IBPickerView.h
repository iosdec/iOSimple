//
//  IBPickerView.h
//  iOSDec
//
//  Created by Declan Land.
//  Copyright Declan Land.
//

#import <UIKit/UIKit.h>

#import "IBPickerItem.h"

@class IBPickerItem;

/*!
 @brief Displays custom view that will present a picker.
 @discussion Data can be provided through interface builder, or programatically. Also supports interface builder @SELECTOR; NSSelectorFromString will be called if this is set, and the sender will be automatically fetched from the controller that the view is contained in.
*/
@interface IBPickerView : UIView

/*!
 @brief Determine whether the view is setup.
*/
@property (nonatomic, assign) BOOL alreadySetup;

/*!
 @brief Width of the border.
*/
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/*!
 @brief Border colour - setup border only if this is set.
*/
@property (strong, nonatomic) IBInspectable UIColor *borderColour;

/*!
 @brief Corner radius of the view.
*/
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/*!
 @brief Image that will be shown to the right.
*/
@property (strong, nonatomic) IBInspectable UIImage *rightImage;

/*!
 @brief Alpha of the right image.
 */
@property (nonatomic, assign) IBInspectable CGFloat rightImageOpacity;

/*!
 @brief Flip the right image upside down when active if this is set.
 @discussion Also does the opposite when turning "inactive".
*/
@property (nonatomic, assign) IBInspectable BOOL flipImageWhenActive;

/*!
 @brief Determine whether the view is "active".
*/
@property (nonatomic, assign) IBInspectable BOOL isActive;

/*!
 @brief Placeholder Text.
*/
@property (strong, nonatomic) IBInspectable NSString *placeholder;

#pragma mark    -   Data / Selector:

/*!
 @brief Data to present - seperate with comma's.
 @discussion Example: item1,item2,item3,another item,etc.
*/
@property (strong, nonatomic) IBInspectable NSString *stringDataSource;

/*!
 @brief Data to present.
 @discussion Will overide stringDataSource.- (void)setActive:(BOOL)active
*/
@property (strong, nonatomic) NSArray *dataSource;

/*!
 @brief Selector to call when finished.
 @discussion Target will be automatically fetched from the first responder.
*/
@property (strong, nonatomic) IBInspectable NSString *callbackString;

/*!
 @brief Target to call the selector on - for callback.
*/
@property (strong, nonatomic) id sender;

/*!
 @brief Selector to call when finished.
*/
@property (nonatomic, assign) SEL callbackSelector;

#pragma mark    -   Actions:

/*!
 @brief Make the selection box active / inactive.
 @param active YES / NO value to make the view active / inactive.
*/
- (void)setActive:(BOOL)active;

/*!
 @brief Called when item is picked.
*/
- (void)itemPicker:(IBPickerItem *)item;

#pragma mark    -   Outlets:

/*!
 @brief Displays placeholder / selection.
*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/*!
 @brief Displays right image.
*/
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end
