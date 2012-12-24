//
//  CCYearMonthPickerController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCYearMonthPickerController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@end
