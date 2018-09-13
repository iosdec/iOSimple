//
//  DropdownCell.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDropdownCellHeight 43

@interface DropdownCell : UIView

@property (weak, nonatomic) IBOutlet UIView *imgContainer;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkedImage;
@property (weak, nonatomic) IBOutlet UIView *checkedContainer;

@property (nonatomic, assign) BOOL isChecked;
@property (strong, nonatomic) NSString *value;

- (id)initWithValue:(NSString *)value;
- (void)check:(BOOL)checked;

@end
