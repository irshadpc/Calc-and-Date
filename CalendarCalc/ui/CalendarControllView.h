//
//  CalendarControllView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/19.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarView;
@protocol CalendarControllViewDelegate;

@interface CalendarControllView : UIView
@property(weak, nonatomic) id<CalendarControllViewDelegate> delegate;
@property(strong, nonatomic, readonly) UIButton *dateSelectButton;
@property(strong, nonatomic, readonly) UIButton *prevButton;
@property(strong, nonatomic, readonly) UIButton *nextButton;
@property(strong, nonatomic) NSDate *currentDate;

- (id)initWithCalendarView:(CalendarView *)calendarView;
@end

@protocol CalendarControllViewDelegate<NSObject>
- (NSDate *)calendarControllView:(CalendarControllView *)calendarControllView pressPrevMonthButton:(UIButton *)prevMonthButton;
- (NSDate *)calendarControllView:(CalendarControllView *)calendarControllView pressNextMonthButton:(UIButton *)nextMonthBUtton;
- (void)calendarControllView:(CalendarControllView *)calendarControllView pressDateSelectButton:(UIButton *)dateSelectButton;
@end