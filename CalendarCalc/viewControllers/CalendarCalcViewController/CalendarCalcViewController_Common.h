//
//  CalendarCalcViewController_Common.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/20.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController.h"

@class CalendarViewController;
@class EventViewController;

@interface CalendarCalcViewController ()
@property(weak, nonatomic) IBOutlet UIButton *clearButton;
@property(strong, nonatomic) CalendarViewController *calendarViewController;
@property(strong, nonatomic) EventViewController *eventViewController;

- (void)showCalendarView;
@end
