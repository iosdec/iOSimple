//
//  Multiview.m
//  SuperbiOS
//
//  Created by R3V0 on 08/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import "Multiview.h"

@implementation Multiview

#pragma mark    -   Horizonal Align:

+ (void)horizontallyAlign:(NSArray *)views target:(CGFloat)centerX container:(id)container {
    
    if (!views) { return; }
    
    if (views.count == 0) { return; }
    
    if (!container) { return; }
    
    NSUInteger current  =   0;
    UIView *_container  =   (UIView *)container;
    
    //  let's create a uiview with the same width as the container:
    
    UIView *main        =   [[UIView alloc] init];
    main.frame          =   CGRectMake(0, 0, _container.frame.size.width, 120);
    
    //  now.. add the views into this main view and just place them at the center:
    
    for (UIView *view in views) {
        
        [main addSubview:view];
        [view setCenter:CGPointMake(main.center.x, main.center.y)];
        
        //  now.. let's get the previous view:
        
        current++;
        
    }
    
}

#pragma mark    -   Horizontal Align with options:

+ (void)horizontallyAlign:(NSArray *)views target:(CGFloat)centerX container:(id)container options:(MultiviewOption)options {
    
    
    
}

#pragma mark    -   Vertically Align:

+ (void)verticallyAlign:(NSArray *)views target:(CGFloat)centerY container:(id)container {
    
    
    
}

#pragma mark    -   Vertically Align with options:

+ (void)verticallyAlign:(NSArray *)views target:(CGFloat)centerY container:(id)container options:(MultiviewOption)options {
    
    
    
}

@end
