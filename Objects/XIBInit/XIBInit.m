//
//  XIBInit.m
//  SuperbiOS
//
//  Created by R3V0 on 02/10/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import "XIBInit.h"

@implementation XIBInit

+ (id)xibWithClass:(Class)className {
    
    //  warning.. loadNibNamed will automatically call viewDidLoad.
    //  so setting properties after the loadNibNamed method is called
    //  will be useless.. so keep viewDidLoad clear and use a custom
    //  method instead.
    //  quite stupid that there isn't a UINibOptionStaticLoad option
    //  that would cancel the viewDidLoad method. apPlE
    
    NSArray *items          =   [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(className) owner:self options:nil];
    
    if (items.count == 0) {
        return nil;
    } else {
        return items[0];
    }
    
}

+ (id)xibWithClass:(Class)className index:(int)index {
    
    NSArray *items  =   [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(className) owner:self options:nil];
    
    if (items.count == 0) {
        return nil;
    }
    
    if ((items.count - 1) < index) {
        return nil;
    }
    
    return items[index];
    
}

+ (id)xibWithClass:(Class)className index:(int)index bundle:(NSBundle *)bundle {
    
    if (![[NSBundle allBundles] containsObject:bundle]) {
        bundle = [NSBundle mainBundle];
    }
    
    NSArray *items  =   [bundle loadNibNamed:NSStringFromClass(className) owner:self options:nil];
    
    if (items.count == 0) {
        return nil;
    }
    
    if ((items.count - 1) < index) {
        return nil;
    }
    
    return items[index];
    
}

@end
