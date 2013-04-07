//
//  CCCalendarCalcViewController_iPad.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/03.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcViewController.h"

@interface CalendarCalcViewController_iPad : CalendarCalcViewController <UIPopoverControllerDelegate>
@property(weak, nonatomic) IBOutlet UIButton *eventButton;
@property(weak, nonatomic) IBOutlet UIView *calendarViewContainer;
@property(weak, nonatomic) IBOutlet UIView *calcViewContainer;
@property(weak, nonatomic) IBOutlet UIView *dateSelectButtonContainer;
@property(weak, nonatomic) IBOutlet UIView *prevButtonContainer;
@property(weak, nonatomic) IBOutlet UIView *nextButtonContainer;
@end
