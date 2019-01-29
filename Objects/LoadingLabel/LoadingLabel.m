//
//  LoadingLabel.m
//  SuperbiOS
//
//  Created by R3V0 on 03/12/2018.
//  Copyright © 2018 Superb. All rights reserved.
//

#import "LoadingLabel.h"

@implementation UILabel (LoadingLabel)

- (void)startLoading {
    
    if (![self.text isEqualToString:@"Loading"] && ![self.text isEqualToString:@"Loading."] && ![self.text isEqualToString:@"Loading.."] && ![self.text isEqualToString:@"Loading..."]) {
        self.accessibilityIdentifier = @"loading";
    }
    
    if ([self.accessibilityIdentifier isEqualToString:@"loading"]) {
        
        //  this is the first condition.
        //  this will be the starting point
        
        if ([self.text isEqualToString:@"Loading"]) {
            self.text = @"Loading.";
        }
        
        else if ([self.text isEqualToString:@"Loading."]) {
            self.text = @"Loading..";
        }
        
        else if ([self.text isEqualToString:@"Loading.."]) {
            self.text = @"Loading...";
        }
        
        else if ([self.text isEqualToString:@"Loading..."]) {
            self.text = @"Loading";
        }
        
        else {
            self.text = @"Loading";
        }
        
        //  perform:
        [self performSelector:@selector(startLoading) withObject:nil afterDelay:0.7];
        
    }
    
}

- (void)stopLoading:(NSString *)string {
    self.accessibilityIdentifier = nil;
    self.text = string;
}

@end
