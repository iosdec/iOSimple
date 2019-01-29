//
//  IBView.h
//  Declan Land
//
//  Created by Declan Land
//  Copyright Declan Land
//

#import <UIKit/UIKit.h>

/*!
 @brief UIView with Interface Builder extensions.
*/
@interface IBView : UIView

/*!
 @brief Determine whether the view is setup.
*/
@property (nonatomic, assign) BOOL alreadySetup;

/*!
 @brief Border Colour of the view.
*/
@property (strong, nonatomic) IBInspectable UIColor *borderColour;

/*!
 @brief Border Width of the view.
*/
@property (nonatomic, assign) IBInspectable float borderWidth;

/*!
 @brief Corner Radius of the view.
*/
@property (nonatomic, assign) IBInspectable float cornerRadius;

@end
