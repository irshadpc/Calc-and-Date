//
//  ASCCalendarView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASCCalendarViewDelegate;

@interface ASCCalendarView : UIView

@property (weak, nonatomic) id <ASCCalendarViewDelegate> delegate;
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic) CGSize calendarButtonSize;

- (id)initWithCalendarButtonSize:(CGSize)calendarButtonSize;
- (void)prevMonth;
- (void)nextMonth;
- (void)reloadCalendarViewWithYear:(NSInteger)year month:(NSInteger)month;
@end

@protocol ASCCalendarViewDelegate <NSObject>
@optional
- (void)calendarView:(ASCCalendarView *)view onTouchUpInside:(NSDate *)date;

@end