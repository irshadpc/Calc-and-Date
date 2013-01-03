//
//  CCYearMonthPickerController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCYearMonthPickerControllerDelegate;

@interface CCYearMonthPickerController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) id <CCYearMonthPickerControllerDelegate> delegate;
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@end

@protocol CCYearMonthPickerControllerDelegate <NSObject>

- (void)yearMonthPickearControllerDidDone:(CCYearMonthPickerController *)yearMonthPickerController;

@end