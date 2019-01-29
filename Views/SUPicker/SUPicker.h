//
//  SUPicker.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XIBInit.h"

typedef enum {
    SUPickerHeight          =   337,    //  height
    SUPickerWidth           =   320,    //  width
}SUPickerSize;

typedef enum {
    SUPickerTypeNone        =   0,      //  normal.
    SUPickerTypeDate        =   1,      //  date.
    SUPickerTypeTime        =   2,      //  time.
    SUPickerTypeDateTime    =   3,      //  datetime.
}SUPickerType;

@interface SUPicker : UIView

/*! @brief SUPicker with array of strings. */
+ (id)pickerWithData:(NSArray <NSString *> *)data;

/*! @brief Date picker type. */
+ (id)pickerWithType:(SUPickerType)type previousDate:(NSDate *)date;

/*! @brief Present at bottom of screen - uses top controller. */
- (void)presentAtBottom:(void(^)(id item))completion;

/*! @brief Present in middle of screen - uses top controller. */
- (void)presentInMiddle:(void(^)(id item))completion;

/*! @brief Present at custom point - requires view. */
- (void)presentAtPoint:(CGPoint)point container:(UIView *)container action:(void(^)(id item))completion;

/*! @brief Set title label text. */
- (void)setTitle:(NSString *)text;

/*! @brief Set message text. */
- (void)setMessage:(NSString *)message;

/*! @brief Stored source. */
@property (strong, nonatomic) NSArray <NSString *> *data;

/*! @brief Container to present view in. */
@property (strong, nonatomic) UIView *container;

/*! @brief Blurred background view. */
@property (strong, nonatomic) UIView *blurView;

typedef void (^pickedAction) (id item);
@property (nonatomic, copy) pickedAction completion;
@property (nonatomic, assign) SUPickerType type;

#pragma mark    -   Outlets:

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *customPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *customDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *topview;

@end
