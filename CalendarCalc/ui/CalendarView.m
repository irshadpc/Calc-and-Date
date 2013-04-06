//
//  CalendarView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarButton.h"
#import "NSArray+Safe.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "UIImage+Calendar.h"

@interface CalendarView ()
@property(nonatomic, readwrite) NSInteger year;
@property(nonatomic, readwrite) NSInteger month;
@property(nonatomic, readwrite) CGSize buttonSize;
@property(strong, nonatomic) CalendarButton *selectedButton;
@property(nonatomic) NSInteger selectedYear;
@property(nonatomic) NSInteger selectedMonth;
@property(nonatomic) NSInteger selectedDay;

- (void)reloadCalendarView;
- (void)reloadEventDates;
- (void)setupCalendarButtons;
- (void)onPressCalendarButton:(CalendarButton *)sender;
- (CGRect)calendarViewFrame;
@end

@implementation CalendarView
+ (CalendarView *)calendarViewWithYear:(NSInteger)year
                                    month:(NSInteger)month
{
    CalendarView *calendarView = [[CalendarView alloc] initWithMargin:6.0];
    [calendarView setYear:year month:month];
    return calendarView;
}

- (id)initWithMargin:(CGFloat)margin
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _buttonSize = CGSizeMake(66.0, 66.0);
    } else {
        _buttonSize = CGSizeMake(44.0, 44.0);
    }
    _margin = margin;

    if ((self = [super initWithFrame:[self calendarViewFrame]])) {
        NSDate *date = [NSDate date];
        _year = [date year];
        _month = [date month];
        [self setupCalendarButtons];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self reloadCalendarView];
}

- (void)setMargin:(CGFloat)margin
{
    _margin = margin;
    [self setFrame:[self calendarViewFrame]];
    [self reloadCalendarView];
}

- (void)setYear:(NSInteger)year
          month:(NSInteger)month
{
    if (self.year == year && self.month == month) {
        return;
    }
    NSDate *date = [NSDate dateWithYear:year
                                  month:month
                                    day:1];
    self.year = [date year];
    self.month = [date month];
    [self reloadCalendarView];
}

- (void)setEventDates:(NSArray *)eventDates
{
    if (_eventDates != eventDates) {
        _eventDates = eventDates;
    }
    [self reloadEventDates];
}

- (void)prevMonth
{
    NSDate *date = [NSDate dateWithYear:self.year
                                  month:self.month - 1
                                    day:1];
    self.year = [date year];
    self.month = [date month];
    [self reloadCalendarView];
}

- (void)nextMonth
{
    NSDate *date = [NSDate dateWithYear:self.year
                                  month:self.month + 1
                                    day:1];
    self.year = [date year];
    self.month = [date month];
    [self reloadCalendarView];
}


#pragma mark - Private

- (void)reloadCalendarView
{
    NSDate *startOfMonth = [NSDate dateWithYear:self.year
                                          month:self.month
                                            day:1];
    NSInteger firstDay = 1 - [startOfMonth weekday];
    
    
    NSDate *endOfMonth = [NSDate endOfMonthWithYear:self.year
                                              month:self.month];
    NSInteger lastDay = [endOfMonth day] + (Saturday - [endOfMonth weekday]);
    NSInteger endOfMonthDay = [endOfMonth day];

    NSInteger today = NSIntegerMin;
    NSDate *date = [NSDate date];
    if (self.year == [date year] && self.month == [date month]) {
        today = [date day];
    }
   
    NSInteger selectedDay = NSIntegerMin;
    if (self.year == self.selectedYear && self.month == self.selectedMonth) {
        selectedDay = self.selectedDay;
    }

    NSInteger targetDay = firstDay - 1;
    NSInteger dayOfMonth = [[NSDate dateWithYear:self.year
                                           month:self.month
                                             day:firstDay] day];
    NSInteger calendarIndex = 0;
    for (NSInteger week = 1; week <= 6; week++) {
        for (NSInteger weekday = Sunday; weekday <= Saturday; weekday++) {
            targetDay++;
            dayOfMonth++;
            calendarIndex++;
            
            CalendarButton *calendarButton = (CalendarButton *) [self viewWithTag:calendarIndex];
            if (targetDay >= lastDay) {
                [calendarButton setHidden:YES];
                continue;
            }
            
            if (targetDay == 0 || targetDay == endOfMonthDay) {
                dayOfMonth = 1;
            }
            [calendarButton setHidden:NO];
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
            [calendarButton setToday:[calendarButton dayOfCalendar] == today];
            [calendarButton setOn:[calendarButton dayOfCalendar] == selectedDay];
            if ([calendarButton isOn]) {
                self.selectedButton = calendarButton;
            }
        }
    }
   
    [self reloadEventDates];
}

- (void)onPressCalendarButton:(CalendarButton *)sender
{
    [self.delegate calendarView:self didSelectDate:[NSDate dateWithYear:sender.year
                                                                  month:sender.month
                                                                    day:sender.dayOfCalendar]];
    [self.selectedButton setOn:NO];
    [sender setOn:YES];
    self.selectedButton = sender;
    self.selectedYear = sender.year;
    self.selectedMonth = sender.month;
    self.selectedDay = sender.dayOfCalendar;
}

- (void)reloadEventDates
{
    NSUInteger subViewIndex = 0;
    for (NSDate *eventDate in self.eventDates) {
        if ([eventDate year] != self.year || [eventDate month] != self.month) {
            continue;
        }

        NSInteger day = [eventDate day];
        for (NSUInteger index = subViewIndex; index < [self.subviews count]; index++) {
            id subView = self.subviews[index];
            if ([subView tag] < 0) {
                continue;
            }

            if ([subView dayOfCalendar] == day) {
                [subView setHasEvent:YES];
                subViewIndex = index + 1;
                break;
            } else {
                [subView setHasEvent:NO];
            }
        }
    }
    for (NSUInteger index = subViewIndex; index < [self.subviews count]; index++) {
        id subView = self.subviews[index];
        if ([subView tag] < 0) {
            continue;
        }
        [subView setHasEvent:NO];
    }
}

- (void)setupCalendarButtons
{
    NSInteger calendarIndex = 1;
    for (NSInteger week = 1; week <= 6; week ++) {
        for (NSInteger weekday = Sunday; weekday <= Saturday; weekday++) {
            CalendarButton *calendarButton = [[CalendarButton alloc] init];
            [calendarButton addTarget:self
                               action:@selector(onPressCalendarButton:)
                     forControlEvents:UIControlEventTouchUpInside];
            
            [calendarButton setFrame:CGRectMake(self.margin + (self.buttonSize.width * (weekday - 1)),
                                                self.buttonSize.height * (week - 1),
                                                self.buttonSize.width,
                                                self.buttonSize.height)];
            [calendarButton setTag:calendarIndex];
            
            [self addSubview:calendarButton];
            calendarIndex++;
        }
    }
}

- (CGRect)calendarViewFrame
{
    return CGRectMake(self.frame.origin.x,
                      self.frame.origin.y,
                      (_buttonSize.width * 7) + (_margin * 2),
                      (_buttonSize.height * 6) + _margin);
}
@end