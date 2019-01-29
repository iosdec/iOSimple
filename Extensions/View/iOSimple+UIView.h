//
//  iOSimple+UIView.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/*!
 @brief Easy Masks.
 @discussion Saves time having to add every single one.
*/
typedef enum {
    MaskTypeFull                =   1,  //  All Red Markers set.
    MaskTypeStretchyWidth       =   2,  //  Left / Right horizontals set.
    MaskTypeStretchyHeight      =   3,  //  Top / Bottom veritcals set.
    MaskTypeStretchyWidthFull   =   4,  //  All horitonals set.
    MaskTypeStretchyHeightFull  =   5,  //  All verticals set.
    MaskTypeStretchyWidthCenter =   6,  //  Middle horizontals set.
    MaskTypeStretchyHeightCenter=   7,  //  Middle verticals set.
    
    MaskTypeTop                 =   10, //  Top marker set.
    MaskTypeBottom              =   11, //  Bottom marker set.
    MaskTypeLeft                =   12, //  Left marker set.
    MaskTypeRight               =   13, //  Right marker set.
    
    MaskTypeTopLeft             =   14, //  Top and Left markers set.
    MaskTypeTopRight            =   15, //  Top and Right markers set.
    MaskTypeTopBottom           =   16, //  Top and Bottom markers set.
    
    MaskTypeBottomLeft          =   17, //  Bottom and Left markers set.
    MaskTypeBottomRight         =   18, //  Bottom and Right markers set.
    MaskTypeBottomTop           =   19, //  Bottom and Top markers set.
}MaskType;

/*!
 @brief Border Position.
*/
typedef enum {
    BorderPositionTop           =   0,  //  Top of the view
    BorderPositionRight         =   1,  //  Right of the view
    BorderPositionBottom        =   2,  //  Bottom of the view
    BorderPositionLeft          =   3,  //  Left of the view
}BorderPosition;

/*!
 @brief Custom animation options.
*/
typedef enum {
    iOSimpleAnimationOptionGrow     =   0,  //  Grow the view.
    iOSimpleAnimationOptionAlpha    =   1,  //  Change opacity to 0.4 - 1.0.
    iOSimpleAnimationOptionReverse  =   2,  //  Reverse when finished.
}iOSimpleAnimationOption;

/*!
 @brief Custom Shadow Direction.
*/
typedef NS_OPTIONS(NSUInteger, NLInnerShadowDirection) {
    NLInnerShadowDirectionNone   = 0,
    NLInnerShadowDirectionLeft   = (1 << 0),
    NLInnerShadowDirectionRight  = (1 << 1),
    NLInnerShadowDirectionTop    = (1 << 2),
    NLInnerShadowDirectionBottom = (1 << 3),
    NLInnerShadowDirectionAll    = 15
};

@interface UIView (iOSimple_UIView)

/*!
 @brief Set a given Resizing mask.
 @discussion Saves a lot of time instead of typing out every single mask.
*/
- (void)setResizingMask:(MaskType)type;

/*!
 @brief Add a UIButton with the same width / height as the view with a custom action / sender.
 @discussion Really usefull for lazilly adding an action to a view.
 @param selector Selector function to call when the function is completed.
 @param sender Sender to call the function from.
*/
- (void)addMagicButtonWithAction:(SEL)selector sender:(id)sender;

/*!
 @brief Add Magic Button with all custom selectors.
 @discussion Handy for not writing out a big button function over and over.
 @param sender Sender where the selectors are called from.
*/
- (void)addMagicButtonWithSender:(id)sender down:(SEL)down cancel:(SEL)cancel touchUp:(SEL)touchUp;

/*!
 @brief Find UIView with given identifier.
 @discussion View finder is based off of RestorationID - use something else.
*/
- (void)findViewWithIdentifier:(NSString *)identifier completion:(void(^)(id view))completion;

/*!
 @brief Calculate the size of a UIView including sublabels.
*/
- (CGFloat)calculatedWidthWithLabel:(UILabel *)label;

/*!
 @brief All Subviews for view.
*/
- (NSMutableArray *)allSubviews;

/*!
 @brief Find first button in index.
*/
- (UIButton *)firstButtonInIndex;

/*!
 @brief Add Border with position.
 @discussion Adds a sublayer with a custom position and width.
 @param position Position of the border.
 @param width Width of the border.
 @param colour Colour of the border.
*/
- (void)addBorderWithPosition:(BorderPosition)position width:(CGFloat)width colour:(UIColor *)colour;

#pragma mark    -   Shadow:

/**
 * Add Inner shadow to view.
 * Defaults with black shadow at 3.0 radius
 */
- (void)addInnerShadow;

/**
 * Add Inner shadow to view.
 * Defaults with black shadow
 * @param radius    : Thickness of the shadow.
 * @param alpha     : The transparency for the shadow.
 */
- (void)addInnerShadowWithRadius:(CGFloat)radius andAlpha:(CGFloat)alpha;

/**
 * Add Inner shadow to view.
 * @param radius    : Thickness of the shadow.
 * @param color     : The color to use for the shadow.
 */
- (void)addInnerShadowWithRadius:(CGFloat)radius andColor:(UIColor *)color;

/**
 * Add Inner shadow to view.
 * @param radius        : Thickness of the shadow.
 * @param color         : The color to use for the shadow.
 * @param direction     : The view edges to draw the shadow on.
 */
- (void)addInnerShadowWithRadius:(CGFloat)radius andColor:(UIColor *)color inDirection:(NLInnerShadowDirection)direction;

/**
 * Remove any Inner shadow from view.
 */
- (void)removeInnerShadow;

@end
