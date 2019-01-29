//
//  DPicker.h
//  Declan Land
//
//  Created by Declan Land
//  Copyright Declan Land
//

#import <UIKit/UIKit.h>

typedef enum {
    DPickerTypeDateAndTime  =   0,  //  Date And Time
    DPickerTypeDate         =   1,  //  Just Date
    DPickerTypeTime         =   2,  //  Just Time
}DPickerType;

typedef enum {
    DPickerWidth        =   308,    //  Width
    DPickerHeight       =   337,    //  Height
}DPickerSize;

typedef enum {
    DPickerDataTypeDate     =   0,  //  Date / Time Picker.
    DPickerDataTypeCustom   =   1,  //  Custom object picker.
}DPickerDataType;

/*!
 @brief Present a custom Date / Time picker.
*/
@interface DPicker : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

/*!
 @brief Present the date picker with a type.
 @discussion Method will automatically find the bounds of the frame - and the controller.
 @param type Type of date picker to present.
 @param previous Previous date.
 @param source Source view that you will be presenting from.
 @param completion Completion handler.
*/
+ (void)presentWithType:(DPickerType)type previous:(NSDate *)previous source:(id)source completion:(void(^)(NSDate *pickedDate))completion;

/*!
 @brief Present the date picker with a type, container and position.
 @discussion This will be handy when the positions need to be custom set.
 @param type Type of date picker to present.
 @param container Container to present in.
 @param position Custom position.
 @param completion Completion method.
*/
+ (void)presentWithType:(DPickerType)type container:(UIView *)container position:(CGPoint)position completion:(void(^)(NSDate *pickedDate))completion;

/*!
 @brief Present Custom picker view with data source.
 @discussion Method will automatically find the bounds of the frame - and the controller.
 @param data Array of NSString's to choose from.
 @param source Source view that you will be presenting from.
 @param completion Completion handler.
*/
+ (void)presentWithData:(NSArray <NSString *> *)data source:(id)source completion:(void(^)(NSString *pickedObject))completion;

/*!
 @brief Present custom picker with data source in the middle of the screen.
 @param data Data source in Strings.
 @param completion Completion method.
*/
+ (void)presentWithData:(NSArray <NSString *> *)data controller:(UIViewController *)controller completion:(void(^)(NSString *pickedObject))completion;

/*!
 @brief Present custom picker with data source AND container WITH custom position.
 @param data Data source in strings.
 @param container Container to add the view into.
 @param position Custom position.
 @param completion Completion method.
*/
+ (void)presentWithData:(NSArray<NSString *> *)data container:(UIView *)container position:(CGPoint)position completion:(void (^)(NSString *))completion;

/*!
 @brief Removes any other instances of DPicker in a given controller.
 @discussion Handy for preventing double popups. Automatically called before presenting another view.
 @param controller UIViewController to check.
*/
- (void)removeOtherInstances:(UIViewController *)controller;

/*!
 @brief Dismiss the view and remove instance.
*/
- (void)dismiss;

/*!
 @brief Stored Type.
 @discussion See DPickerType for options.
*/
@property (nonatomic, assign) DPickerType type;

/*!
 @brief Stored data type.
*/
@property (nonatomic, assign) DPickerDataType dataType;

/*!
 @brief Stored Source View.
 @discussion This view will be presented on top of.
*/
@property (strong, nonatomic) id source;

/*!
 @brief Stored View Controller
 */
@property (strong, nonatomic) UIViewController *controller;

/*!
 @brief Stored data source.
*/
@property (strong, nonatomic) NSArray <NSString *> *storedDataSource;

/*!
 @brief Custom completion block.
*/
typedef void (^pickerCompletion) (NSDate *pickedDate);

/*!
 @brief Stored completion block.
*/
@property (nonatomic, copy) pickerCompletion completion;

/*!
 @brief Custom picker completion block.
*/
typedef void (^customCompletion) (NSString *pickedObject);

/*!
 @brief Stored custom completion block.
*/
@property (nonatomic, copy) customCompletion pickerCustomCompletion;

/*!
 @brief Stored picked date.
 @discussion If user cancels, sets to nil.
*/
@property (strong, nonatomic) NSDate *pickedDate;

/*!
 @brief Stored picked object.
 @discussion If user cancells, sets to nil.
*/
@property (strong, nonatomic) NSString *pickedObject;

/*!
 @brief Stored Blur View.
*/
@property (strong, nonatomic) UIView *blurView;

#pragma mark    -   Outlets:

/*!
 @brief Displays title ; which is changeable.
*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/*!
 @brief Picker view that shows the date / time.
*/
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;

/*!
 @brief Custom Picker View.
*/
@property (weak, nonatomic) IBOutlet UIPickerView *customPickerView;

/*!
 @brief Cancel buttton.
*/
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

/*!
 @brief Done button.
*/
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end
