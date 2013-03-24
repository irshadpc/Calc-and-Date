//
//  CCYearMonthPickerController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YearMonthPickerControllerDelegate;

@interface YearMonthPickerController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) id <YearMonthPickerControllerDelegate> delegate;
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@end

@protocol YearMonthPickerControllerDelegate <NSObject>

- (void)yearMonthPickearControllerDidDone:(YearMonthPickerController *)yearMonthPickerController;

@end