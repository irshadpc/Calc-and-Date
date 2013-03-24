//
//  CalendarView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarView.h"
#import "AppDelegate.h"
#import "CalendarConstant.h"
#import "CalendarButton.h"
#import "NSArray+safe.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "UIImage+Calendar.h"
#import "Week.h"

@interface CalendarView ()
@property (nonatomic, readwrite) NSInteger year;
@property (nonatomic, readwrite) NSInteger month;

- (void)reloadCalendarView;
- (void)onPressCalendarButton:(CalendarButton *)sender;
- (CGRect)calendarViewFrameWithButtonSize:(CGSize)buttonSize;
- (void)onClick:(UIButton *)sender;
@end


@implementation CalendarView

- (id)initWithCalendarButtonSize:(CGSize)calendarButtonSize
{
    if ((self = [super initWithFrame:[self calendarViewFrameWithButtonSize:calendarButtonSize]])) {
        NSDate *date = [NSDate date];
        _year = [date year];
        _month = [date month];
        _calendarButtonSize = calendarButtonSize;

        _player = [(AppDelegate *)[[UIApplication sharedApplication] delegate] player];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self reloadCalendarView];
}

- (void)setCalendarButtonSize:(CGSize)calendarButtonSize
{
    if (CGSizeEqualToSize(_calendarButtonSize, calendarButtonSize)) {
        return;
    }
    _calendarButtonSize = calendarButtonSize;
    self.frame = [self calendarViewFrameWithButtonSize:_calendarButtonSize];

    [self reloadCalendarView];
}

- (void)prevMonth
{
    NSDate *date = [NSDate dateWithYear: self.year
                                  month: self.month - 1
                                    day: 1];
    self.year = [date year];
    self.month = [date month];
    [self reloadCalendarView];
}

- (void)nextMonth
{
    NSDate *date = [NSDate dateWithYear: self.year
                                  month: self.month + 1
                                    day: 1];
    self.year = [date year];
    self.month = [date month];

    [self reloadCalendarView];
}

- (void)reloadCalendarViewWithYear:(NSInteger)year
                             month:(NSInteger)month
{
    if (self.year == year && self.month == month) {
        return;
    }

    self.year = year;
    self.month = month;
    [self reloadCalendarView];
}


#pragma mark - Private

- (void)reloadCalendarView
{
    NSInteger subBaseY = 0;
    NSDate *startOfMonth = [NSDate dateWithYear: self.year
                                          month: self.month
                                            day: 1];
    NSDate *endOfMonth = [NSDate endOfMonthWithYear: self.year
                                              month: self.month];
    
    NSInteger firstDay = 1 - [startOfMonth weekday];
    NSInteger lastDay = [endOfMonth day] + (Saturday - [endOfMonth weekday]);
   
    NSInteger weekday = Sunday;
    NSInteger dayOfMonth = [[NSDate dateWithYear: self.year
                                           month: self.month
                                             day: firstDay + 1] day];
    NSInteger endOfMonthDay = [endOfMonth day];
    NSInteger calendarIndex = 1;
    for (NSInteger targetDay = firstDay; targetDay < lastDay; targetDay++) {
        if (targetDay == 0 || targetDay == endOfMonthDay) {
            dayOfMonth = 1;
        }
        
        CalendarButton *calendarButton = (id)[self viewWithTag:calendarIndex];
        if (!calendarButton) {
            calendarButton = [[CalendarButton alloc] init];

            [self addSubview:calendarButton];

            [calendarButton addTarget:self
                               action:@selector(onPressCalendarButton:)
                     forControlEvents:UIControlEventTouchUpInside];
           
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [calendarButton addTarget:self
                                   action:@selector(onClick:)
                         forControlEvents:UIControlEventTouchDown];
            }
        }

        [calendarButton setDayOfCalendar:targetDay + 1];
        [calendarButton setYear:self.year];
        [calendarButton setMonth:self.month];
        [calendarButton setDayOfMonth:dayOfMonth];
        if (targetDay < 0 || targetDay >= endOfMonthDay) {
            [calendarButton setOtherMonthDate:YES];
        } else {
            [calendarButton setOtherMonthDate:NO];
        }
        [calendarButton setWeekday:weekday];

        if (weekday == Sunday) {
            subBaseY++;
        }

        [calendarButton setFrame:CGRectMake(CalendarMargin + (self.calendarButtonSize.width * (weekday - 1)),
                                            self.calendarButtonSize.height * (subBaseY - 1),
                                            self.calendarButtonSize.width,
                                            self.calendarButtonSize.height)];
        
        [calendarButton setTag:calendarIndex];
        
        weekday++;
        if (weekday > Saturday) {
            weekday = Sunday;
        }
        
        dayOfMonth++;
        calendarIndex++;
    }
    
    CalendarButton *restButton = (id)[self viewWithTag:calendarIndex];
    while (restButton) {
        calendarIndex++;
        [restButton removeFromSuperview];
        restButton = (id)[self viewWithTag:calendarIndex];
    }
}

- (void)onPressCalendarButton:(CalendarButton *)sender
{
    [self.delegate calendarView:self onTouchUpInside:[NSDate dateWithYear:sender.year
                                                                    month:sender.month
                                                                      day:sender.dayOfCalendar]];
}

- (CGRect)calendarViewFrameWithButtonSize:(CGSize)buttonSize
{
    return CGRectMake(self.frame.origin.x,
                      self.frame.origin.y,
                      (buttonSize.width * 7) + (CalendarMargin * 2),
                      (buttonSize.height * WeekCount) + CalendarMargin);
}

- (void)onClick:(UIButton *)sender
{
    [self.player setCurrentTime:0];
    [self.player play];
}

@end
