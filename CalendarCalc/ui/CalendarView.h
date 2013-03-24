//
//  CalendarView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarViewDelegate;

@interface CalendarView : UIView
@property(weak, nonatomic) id<CalendarViewDelegate> delegate;
@property(nonatomic, readonly) NSInteger year;
@property(nonatomic, readonly) NSInteger month;
@property(strong, nonatomic) NSArray *eventDates;
@property(nonatomic, readonly) CGSize buttonSize;
@property(nonatomic) CGFloat margin;

+ (CalendarView *)calendarViewWithYear:(NSInteger)year month:(NSInteger)month;
- (id)initWithMargin:(CGFloat)margin;
- (void)prevMonth;
- (void)nextMonth;
- (void)setYear:(NSInteger)year month:(NSInteger)month;
@end

@protocol CalendarViewDelegate<NSObject>
@required
- (void)calendarView:(CalendarView *)calendarView didSelectDate:(NSDate *)date;
@end