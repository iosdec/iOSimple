//
//  iOSimple+UIView.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "iOSimple+UIView.h"
#import "HapticHelper.h"
#import "iOSimple+UILabel.h"

@implementation UIView (iOSimple_UIView)

- (void)setResizingMask:(MaskType)type {
    
    if (type == MaskTypeFull) {
        self.autoresizingMask   =   UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    
    if (type == MaskTypeStretchyWidth) {
        self.autoresizingMask   =   UIViewAutoresizingFlexibleWidth;
    }
    
    if (type == MaskTypeStretchyHeight) {
        self.autoresizingMask   =   UIViewAutoresizingFlexibleHeight;
    }
    
    if (type == MaskTypeStretchyWidthFull) {
        self.autoresizingMask   =   UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    
    if (type == MaskTypeStretchyHeightFull) {
        self.autoresizingMask   =   UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    
    //  still left to do
    
}

- (void)addMagicButtonWithAction:(SEL)selector sender:(id)sender {
    
    self.userInteractionEnabled =   YES;
    UIButton *button            =   [[UIButton alloc] init];
    button.frame                =   CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    [button setResizingMask:MaskTypeFull];
    [button addTarget:self action:@selector(buttonAction_touchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(buttonAction_touchCancel:) forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragExit | UIControlEventTouchDragEnter | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside];
    [button addTarget:self action:@selector(buttonAction_touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:sender action:selector forControlEvents:UIControlEventTouchUpInside];
    
    //  check for other buttons:
    
    UIButton *firstButton       =   [self firstButtonInIndex];
    
    if (firstButton) {
        [self insertSubview:button belowSubview:firstButton];
    } else {
        [self addSubview:button];
    }
    
}

- (void)addMagicButtonWithSender:(id)sender down:(SEL)down cancel:(SEL)cancel touchUp:(SEL)touchUp {
    
    UIButton *button        =   [[UIButton alloc] init];
    button.frame            =   CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [button setResizingMask:MaskTypeFull];
    
    if ([sender respondsToSelector:down]) {
        [button addTarget:sender action:down forControlEvents:UIControlEventTouchDown];
    }
    if ([sender respondsToSelector:cancel]) {
        [button addTarget:sender action:cancel forControlEvents:UIControlEventTouchCancel | UIControlEventTouchDragExit | UIControlEventTouchDragEnter | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside];
    }
    if ([sender respondsToSelector:touchUp]) {
        [button addTarget:sender action:touchUp forControlEvents:UIControlEventTouchUpInside];
    }
    
    //  check for other buttons:
    
    UIButton *firstButton       =   [self firstButtonInIndex];
    
    if (firstButton) {
        [self insertSubview:button belowSubview:firstButton];
    } else {
        [self addSubview:button];
    }
    
}

#pragma mark    -   Button Actions  -   Standard.

- (void)buttonAction_touchDown:(UIButton *)button {
    [UIView animateWithDuration:0.2 animations:^{
        self.transform      =   CGAffineTransformMakeScale(1.02, 1.02);
    }];
}

- (void)buttonAction_touchCancel:(UIButton *)button {
    [UIView animateWithDuration:0.1 animations:^{
        self.transform      =   CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)buttonAction_touchUpInside:(UIButton *)button {
    [UIView animateWithDuration:0.1 animations:^{
        self.transform      =   CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        [HapticHelper generateFeedback:FeedbackType_Selection];
    }];
}










#pragma mark    -   Getters:

- (UIButton *)firstButtonInIndex {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            return (UIButton *)obj;
        }
    } return nil;
}

- (NSMutableArray *)allSubviews {
    NSMutableArray *subs = [[NSMutableArray alloc] init];
    [subs addObject:self];
    for (UIView *subview in self.subviews) {
        [subs addObjectsFromArray:(NSArray *)[subview allSubviews]];
    } return subs;
}

- (void)findViewWithIdentifier:(NSString *)identifier completion:(void (^)(id))completion {
    for (UIView *view in [self allSubviews]) {
        if ([view.restorationIdentifier isEqualToString:identifier]) {
            completion(view);
        }
    }
}

- (CGFloat)calculatedWidthWithLabel:(UILabel *)label {
    return (self.frame.size.width - label.frame.size.width) + [label calculatedWidth];
}

#pragma mark    -   Border:

- (void)addBorderWithPosition:(BorderPosition)position width:(CGFloat)width colour:(UIColor *)colour {
    
    CALayer *border         =   [CALayer layer];
    
    if (position == BorderPositionTop) {
        border.frame        =   CGRectMake(0, 0, self.frame.size.width, width);
    }
    
    if (position == BorderPositionRight) {
        border.frame        =   CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
    }
    
    if (position == BorderPositionBottom) {
        border.frame        =   CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
    }
    
    if (position == BorderPositionLeft) {
        border.frame        =   CGRectMake(0, 0, width, self.frame.size.height);
    }
    
    border.backgroundColor  =   colour.CGColor;
    [self.layer addSublayer:border];
    
}

#define kDEFAULT_SHADOW_COLOR [UIColor blackColor]
#define kInnerShadowViewTag 2639
#pragma mark    -   Shadow:

- (void)removeInnerShadow {
    for (UIView *view in self.subviews) {
        if(view.tag == kInnerShadowViewTag) {
            [view removeFromSuperview];
            break;
        }
    }
}

- (void)addInnerShadow {
    UIColor *color = [kDEFAULT_SHADOW_COLOR colorWithAlphaComponent:0.5f];
    [self addInnerShadowWithRadius:3.0f andColor:color inDirection:NLInnerShadowDirectionAll];
}

- (void)addInnerShadowWithRadius:(CGFloat)radius andAlpha:(CGFloat)alpha {
    UIColor *color = [kDEFAULT_SHADOW_COLOR colorWithAlphaComponent:alpha];
    [self addInnerShadowWithRadius:radius andColor:color inDirection:NLInnerShadowDirectionAll];
}

- (void)addInnerShadowWithRadius:(CGFloat)radius andColor:(UIColor *)color {
    [self addInnerShadowWithRadius:radius andColor:color inDirection:NLInnerShadowDirectionAll];
}

- (void)addInnerShadowWithRadius:(CGFloat)radius andColor:(UIColor *)color inDirection:(NLInnerShadowDirection)direction {
    [self removeInnerShadow];
    UIView *shadowView = [self createShadowViewWithRadius:radius andColor:color inDirection:direction];
    [self addSubview:shadowView];
}

- (UIView *)createShadowViewWithRadius:(CGFloat)radius andColor:(UIColor *)color inDirection:(NLInnerShadowDirection)direction {
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    shadowView.backgroundColor = [UIColor clearColor];
    shadowView.tag = kInnerShadowViewTag;
    
    CAGradientLayer *shadow;
    NSArray *colorsArray = @[(id)[color CGColor], (id)[[UIColor clearColor] CGColor]];
    
    if(direction & NLInnerShadowDirectionTop) {
        shadow = [CAGradientLayer layer];
        shadow.colors = colorsArray;
        shadow.startPoint = CGPointMake(0.5, 0.0);
        shadow.endPoint = CGPointMake(0.5, 1.0);
        shadow.frame = CGRectMake(0, 0, self.bounds.size.width, radius);
        [shadowView.layer insertSublayer:shadow atIndex:0];
    }
    
    if(direction & NLInnerShadowDirectionBottom) {
        shadow = [CAGradientLayer layer];
        shadow.colors = colorsArray;
        shadow.startPoint = CGPointMake(0.5, 1.0);
        shadow.endPoint = CGPointMake(0.5, 0.0);
        shadow.frame = CGRectMake(0, self.bounds.size.height - radius, self.bounds.size.width, radius);
        [shadowView.layer insertSublayer:shadow atIndex:0];
    }
    
    if(direction & NLInnerShadowDirectionLeft) {
        shadow = [CAGradientLayer layer];
        shadow.colors = colorsArray;
        shadow.frame = CGRectMake(0, 0, radius, self.bounds.size.height);
        shadow.startPoint = CGPointMake(0.0, 0.5);
        shadow.endPoint = CGPointMake(1.0, 0.5);
        [shadowView.layer insertSublayer:shadow atIndex:0];
    }
    
    if(direction & NLInnerShadowDirectionRight) {
        shadow = [CAGradientLayer layer];
        shadow.colors = colorsArray;
        shadow.frame = CGRectMake(self.bounds.size.width - radius, 0, radius, self.bounds.size.height);
        shadow.startPoint = CGPointMake(1.0, 0.5);
        shadow.endPoint = CGPointMake(0.0, 0.5);
        [shadowView.layer insertSublayer:shadow atIndex:0];
    }
    
    return shadowView;
}

@end
