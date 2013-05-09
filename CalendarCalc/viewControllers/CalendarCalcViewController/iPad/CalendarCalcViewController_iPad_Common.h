//
//  CalendarCalcViewController_iPad_Common.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/05/10.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController_iPad.h"

@class CalendarViewController;
@class EventViewController;

@interface CalendarCalcViewController_iPad ()
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
