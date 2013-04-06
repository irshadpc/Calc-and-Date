//
//  CCWeekControllView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Week.h"

@class CalendarView;
@protocol WeekViewDelegate;

@interface WeekView : UIView
@property(weak, nonatomic) id<WeekViewDelegate> delegate;

- (id)initWithCalendarView:(CalendarView *)calendarView;
@end

@protocol WeekViewDelegate<NSObject>
- (void)weekViewStateChanged:(WeekView *)view week:(Week)week on:(BOOL)on;
@end