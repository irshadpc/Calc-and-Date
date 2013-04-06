//
//  DatePickerController.h
//  DateNumber
//
//  Created by Ishida Junichi on 2013/01/10.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerControllerDelegate;

@interface DatePickerController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property(weak, nonatomic) id<DatePickerControllerDelegate> delegate;
@property(nonatomic) NSInteger year;
@property(nonatomic) NSInteger month;
@property(nonatomic) NSInteger day;
@property(nonatomic, getter=isHideDayComponent) BOOL hideDayComponent;
@end

@protocol DatePickerControllerDelegate <NSObject>
@required
- (void)datePickerControllerDidCancel:(DatePickerController *)datePickerController;
- (void)datePickerControllerDidDone:(DatePickerController *)datePickerController
                               year:(NSInteger)year
                              month:(NSInteger)month
                                day:(NSInteger)day;
@end