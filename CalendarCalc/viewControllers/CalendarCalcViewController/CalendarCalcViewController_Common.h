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
@property(weak, nonatomic) IBOutlet UIButton *eventButton;
@property(weak, nonatomic) IBOutlet UIView *calendarViewContainer;
@property(weak, nonatomic) IBOutlet UIView *calcViewContainer;
@property(weak, nonatomic) IBOutlet UIView *dateSelectButtonContainer;
@property(weak, nonatomic) IBOutlet UIView *prevButtonContainer;
@property(weak, nonatomic) IBOutlet UIView *nextButtonContainer;

@property(strong, nonatomic) CalendarViewController *calendarViewController;
@property(strong, nonatomic) EventViewController *eventViewController;
@end
