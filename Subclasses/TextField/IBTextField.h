//
//  IBTextField.h
//  iOSDec
//
//  Created by Declan Land.
//  Copyright Declan Land.
//

#import <UIKit/UIKit.h>

/*!
 @brief Custom Interface Builder Text Field.
*/
@interface IBTextField : UITextField

/*!
 @brief Determine whether the view is setup.
*/
@property (nonatomic, assign) BOOL alreadySetup;

/*!
 @brief Check whether we should override font.
*/
@property (nonatomic, assign) IBInspectable BOOL dontChangeFont;

/*!
 @brief Border Width.
*/
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/*!
 @brief Border Width.
 */
@property (strong, nonatomic) IBInspectable UIColor *borderColour;

/*!
 @brief Corner Radius.
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/*!
 @brief Set padding.
*/
@property (nonatomic, assign) IBInspectable CGFloat padding;

@end
