//
//  iOSimple+UIView.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum {
    MaskTypeFull                =   1,
    MaskTypeStretchyWidth       =   2,
    MaskTypeStretchyHeight      =   3,
    MaskTypeStretchyWidthFull   =   4,
    MaskTypeStretchyHeightFull  =   5,
    MaskTypeStretchyWidthCenter =   6,
    MaskTypeStretchyHeightCenter=   7,
    
    MaskTypeTop                 =   10,
    MaskTypeBottom              =   11,
    MaskTypeLeft                =   12,
    MaskTypeRight               =   13,
    
    MaskTypeTopLeft             =   14,
    MaskTypeTopRight            =   15,
    MaskTypeTopBottom           =   16,
    
    MaskTypeBottomLeft          =   17,
    MaskTypeBottomRight         =   18,
    MaskTypeBottomTop           =   19,
}MaskType;

@interface UIView (iOSimple_UIView)

- (void)setResizingMask:(MaskType)type;
- (void)addMagicButtonWithAction:(SEL)selector sender:(id)sender;
- (void)findViewWithIdentifier:(NSString *)identifier completion:(void(^)(id view))completion;
- (NSMutableArray *)allSubviews;

//  view finder is based off of RestorationID - use something else
//  if this is already in use, such as the accessibilityIdentifier

@end
