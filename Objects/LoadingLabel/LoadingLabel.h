//
//  LoadingLabel.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @brief Animation class for showing "loading" indicator on UILabel.
*/
@interface UILabel (LoadingLabel)

/*!
 @brief Start a loading animation for the label.
 @discussion Stop the animation with stopLoading: and pass the final string.
 */
- (void)startLoading;

/*!
 @brief Stop loading and update the string.
 @param string String to swap after loading stops.
 */
- (void)stopLoading:(NSString *)string;

@end
