//
//  CalendarControllView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/19.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarView;
@protocol CalendarControlViewDelegate;

@interface CalendarControlView : UIView
@property(weak, nonatomic) id<CalendarControlViewDelegate> delegate;
@property(strong, nonatomic, readonly) UIButton *dateSelectButton;
@property(strong, nonatomic, readonly) UIButton *prevButton;
@property(strong, nonatomic, readonly) UIButton *nextButton;
@property(strong, nonatomic) NSDate *currentDate;

- (id)initWithCalendarView:(CalendarView *)calendarView;
@end

@protocol CalendarControlViewDelegate<NSObject>
- (NSDate *)calendarControlView:(CalendarControlView *)calendarControlView pressPrevMonthButton:(UIButton *)prevMonthButton;
- (NSDate *)calendarControlView:(CalendarControlView *)calendarControlView pressNextMonthButton:(UIButton *)nextMonthBUtton;
- (void)calendarControlView:(CalendarControlView *)calendarControlView pressDateSelectButton:(UIButton *)dateSelectButton;
@end