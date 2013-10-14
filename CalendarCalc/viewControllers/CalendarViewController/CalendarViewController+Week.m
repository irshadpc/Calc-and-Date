//
//  CalendarViewController+Week.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/03/25.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarViewController+Week.h"
#import "CalendarViewController_Common.h"
#import "WeekView.h"
#import "DateSelect.h"
#import "UIView+Frame.h"

@implementation CalendarViewController (Week)
- (void)showWeekView
{
    WeekView *weekControllView = [[WeekView alloc] initWithCalendarView:self.calendarViews[1]];
    weekControllView.frame = CGRectMake(weekControllView.frame.origin.x,
                                        self.calendarControllView.frame.origin.y + self.calendarControllView.frame.size.height,
                                        weekControllView.frame.size.width,
                                        weekControllView.frame.size.height);
    [weekControllView setDelegate:self];
    [self.view addSubview:weekControllView];
   
    [self.pageView setFrameOriginY:weekControllView.frame.origin.y + weekControllView.frame.size.height];
    [self.view setFrame:[self viewFrame]];
}


#pragma mark - WeekControllerView

- (void)weekViewStateChanged:(WeekView *)view
                    week:(Week)week
                      on:(BOOL)on
{
    [self.delegate didSelectWeek:week exclude:!on];
}
@end
