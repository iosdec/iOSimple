//
//  LoadingButton.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ButtonLoadingStyleNormal    =   0,  //  animates left into a circle with indicator
    ButtonLoadingStyleIndicator =   1,  //  just use the indicator.. not frame change
}ButtonLoadingStyle;

/*!
 @brief Creates animation for given button.
*/
@interface LoadingButton : NSObject

/*! @brief Stored loading style. */
@property (nonatomic, assign) ButtonLoadingStyle loadingStyle;

/*! @brief Stored button. */
@property (strong, nonatomic) UIButton *button;

/*! @brief Init with button. */
- (id)initWithButton:(UIButton *)button;

/*!
 @brief Start loading with style.
*/
- (void)startLoading:(ButtonLoadingStyle)style;

/*!
 @brief Stop loading.
*/
- (void)stopLoading;

@end
