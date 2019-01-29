//
//  IBTextView.h
//  SuperbiOS
//
//  Created by R3V0 on 10/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @brief Interface Builder Text View.
*/
@interface IBTextView : UITextView

/*!
 @brief Determine whether the view is setup.
*/
@property (nonatomic, assign) BOOL alreadySetup;

/*!
 @brief Colour of the border.
*/
@property (strong, nonatomic) IBInspectable UIColor *borderColour;

/*!
 @brief Width of the border.
*/
@property (nonatomic, assign) IBInspectable float borderWidth;

/*!
 @brief Corner Radius.
*/
@property (nonatomic, assign) IBInspectable float cornerRadius;

@end
