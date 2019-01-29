//
//  LoadingButton.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "LoadingButton.h"

@interface LoadingButton() {
    
    CGRect original_frame;      //  stored original frame.
    CGFloat original_radius;    //  stored corner radius.
    NSString *original_text;    //  stored title.
    
}
@end

@implementation LoadingButton

- (id)initWithButton:(UIButton *)button {
    self = [super init];
    if (self) {
        if (button) {
            self.button = button;
        }
    } return self;
}

#pragma mark    -   Start Loading:

- (void)startLoading:(ButtonLoadingStyle)style {
    
    if (!self.button) {
        return;
    }
    
    //  store the frame:
    self->original_frame    =   CGRectMake(self.button.frame.origin.x, self.button.frame.origin.y, self.button.frame.size.width, self.button.frame.size.height);
    self->original_radius   =   self.button.layer.cornerRadius;
    self->original_text     =   self.button.titleLabel.text;
    
    //  store the animation style:
    self.loadingStyle = style;
    
    //  filter by standard animation:
    if (style == ButtonLoadingStyleNormal) {
        
        //  this involves animating the button left
        //  into a circle, then back again
        [UIView animateWithDuration:0.3 animations:^{
            [self.button setFrame:CGRectMake(self.button.frame.origin.x, self.button.frame.origin.y, self.button.frame.size.height, self.button.frame.size.height)];
            [self.button setTitle:@"" forState:UIControlStateNormal];
            [self.button.layer setCornerRadius:self.button.frame.size.width / 2];
        } completion:^(BOOL finished) {
            
            //  add loading indicator:
            UIActivityIndicatorView *spinner    =   [[UIActivityIndicatorView alloc] init];
            CGFloat margin                      =   8;
            [spinner setFrame:CGRectMake(margin, margin, self.button.frame.size.width - (margin * 2), self.button.frame.size.height - (margin * 2))];
            [spinner startAnimating];
            [self.button addSubview:spinner];
            
        }];
        
        return;
    }
    
    //  filter by just spinner:
    if (style == ButtonLoadingStyleIndicator) {
        
        //  this involves just adding a spinner to the view:
        [UIView animateWithDuration:0.3 animations:^{
            [self.button setTitle:@"" forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            
            //  add loading indicator:
            UIActivityIndicatorView *spinner    =   [[UIActivityIndicatorView alloc] init];
            CGFloat margin                      =   8;
            [spinner setFrame:CGRectMake(margin, margin, self.button.frame.size.width - (margin * 2), self.button.frame.size.height - (margin * 2))];
            [spinner startAnimating];
            [self.button addSubview:spinner];
            [self.button setNeedsDisplay];
            
        }];
        
    }
    
}

#pragma mark    -   Stop Loading:

- (void)stopLoading {
    
    if (!self.button) {
        return;
    }
    
    NSPredicate *pred   =   [NSPredicate predicateWithFormat:@"self isKindOfClass: %@", [UIActivityIndicatorView class]];
    NSArray *filter     =   [self.button.subviews filteredArrayUsingPredicate:pred];
    
    //  remove spinner:
    [UIView animateWithDuration:0.3 animations:^{
        if (filter.count != 0) {
            UIActivityIndicatorView *spinner    =   [filter firstObject];
            [spinner setAlpha:0];
        }
    } completion:^(BOOL finished) {
        
        //  spinner removed
        if (filter.count != 0) {
            UIActivityIndicatorView *spinner    =   [filter firstObject];
            [spinner removeFromSuperview];
        }
        
        //  now check animation type:
        if (self.loadingStyle == ButtonLoadingStyleNormal) {
            
            //  reset content:
            [UIView animateWithDuration:0.3 animations:^{
                [self.button setFrame:CGRectMake(self->original_frame.origin.x, self->original_frame.origin.y, self->original_frame.size.width, self->original_frame.size.height)];
                [self.button.layer setCornerRadius:self->original_radius];
                [self.button setTitle:self->original_text forState:UIControlStateNormal];
            }];
            
        }
        
        //  check for just spinner:
        if (self.loadingStyle == ButtonLoadingStyleIndicator) {
            
            //  reset content:
            [UIView animateWithDuration:0.3 animations:^{
                [self.button setTitle:self->original_text forState:UIControlStateNormal];
            }];
            
        }
        
    }];
    
}

@end
