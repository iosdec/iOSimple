//
//  DropdownView.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>

//
//      Name:           DropdownView
//      How to use:     This is a UIView subclass - place a
//                      UILabel inside and tag it with 1..
//                      also do this with the image
//                      everything else will be auto handled
//

@interface DropdownView : UIView

- (UILabel *)titleLabel;
- (UIImageView *)dropdownImage;
- (void)setText:(NSString *)text;
- (NSArray *)pickedItems;
- (void)show:(UIViewController *)controller;
- (void)hide;

@property (nonatomic, assign) BOOL alreadySetup;
@property (nonatomic, assign) IBInspectable BOOL date;
@property (nonatomic, assign) IBInspectable BOOL multipleSelection;
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSDate *pickedDate;

@end
