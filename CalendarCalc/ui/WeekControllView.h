//
//  CCWeekControllView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Week.h"

@protocol WeekControllViewDelegate;
@class CalendarView;

@interface WeekControllView : UIView
@property (weak, nonatomic) id <WeekControllViewDelegate> delegate;
- (id)initWithCalendarView:(CalendarView *)calendarView;
@end

@protocol WeekControllViewDelegate <NSObject>

- (void)weekControllView:(WeekControllView *)view week:(Week)week on:(BOOL)on;

@end