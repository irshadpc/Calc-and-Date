//
//  ASCCalendarView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASCCalendarViewDelegate;

@interface ASCCalendarView : UIView {
  @private
    NSInteger _year;
    NSInteger _month;
}

@property (weak, nonatomic) id <ASCCalendarViewDelegate> delegate;

- (void)prevMonth;
- (void)nextMonth;
- (void)reloadCalendarViewWithYear:(NSInteger)year month:(NSInteger)month;
@end

@protocol ASCCalendarViewDelegate <NSObject>
@optional
- (void)calendarView:(ASCCalendarView *)view onTouchUpInside:(NSDate *)date;

@end