//
//  ASCCalendarView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "ASCCalendarView.h"
#import "ASCCalendarConstant.h"
#import "ASCCalendarButton.h"
#import "NSArray+safe.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "UIImage+Calendar.h"
#import "ASCWeek.h"

@interface ASCCalendarView ()
@property (nonatomic, readwrite) NSInteger year;
@property (nonatomic, readwrite) NSInteger month;

- (void)reloadCalendarView;
- (void)onPressCalendarButton:(ASCCalendarButton *)sender;
@end


@implementation ASCCalendarView

- (id)initWithFrame:(CGRect)frame
{
    static const CGFloat DefaultSize = 44.0;
    if ((self = [super initWithFrame:CGRectMake(frame.origin.x,
                                                frame.origin.y,
                                                (DefaultSize * 7) + (ASCCalendarMargin * 2),
                                                (DefaultSize * ASCWeekCount) + ASCCalendarMargin)])) {
        NSDate *date = [NSDate date];
        _year = [date year];
        _month = [date month];
        _calendarButtonSize = CGSizeMake(DefaultSize, DefaultSize);
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

    CGRect newFrame = self.frame;
    newFrame.size.width = _calendarButtonSize.width * 7;
    newFrame.size.height = _calendarButtonSize.height * ASCWeekCount;
    self.frame = newFrame;

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
    NSInteger lastDay = [endOfMonth day] + (ASCSaturday - [endOfMonth weekday]);
   
    NSInteger weekday = ASCSunday;
    NSInteger dayOfMonth = [[NSDate dateWithYear: self.year
                                           month: self.month
                                             day: firstDay + 1] day];
    NSInteger endOfMonthDay = [endOfMonth day];
    NSInteger calendarIndex = 1;
    for (NSInteger targetDay = firstDay; targetDay < lastDay; targetDay++) {
        if (targetDay == 0 || targetDay == endOfMonthDay) {
            dayOfMonth = 1;
        }
        
        ASCCalendarButton *calendarButton = (id)[self viewWithTag:calendarIndex];
        if (!calendarButton) {
            calendarButton = [[ASCCalendarButton alloc] init];
            [calendarButton setImage:[UIImage calendarImage] forState:UIControlStateNormal];

            [self addSubview:calendarButton];

            [calendarButton addTarget: self
                               action: @selector(onPressCalendarButton:)
                     forControlEvents: UIControlEventTouchUpInside];
        }

        [calendarButton setDayOfCalendar:targetDay + 1];
        [calendarButton setYear:self.year];
        [calendarButton setMonth:self.month];
        [calendarButton setDayOfMonth:dayOfMonth];
        if (targetDay < 0 || targetDay >= endOfMonthDay) {
            [calendarButton setWeekday:0];
        } else {
            [calendarButton setWeekday:weekday];
        }

        if (weekday == ASCSunday) {
            subBaseY++;
        }

        [calendarButton setFrame:CGRectMake(ASCCalendarMargin + (self.calendarButtonSize.width * (weekday - 1)),
                                            self.calendarButtonSize.height * (subBaseY - 1),
                                            self.calendarButtonSize.width,
                                            self.calendarButtonSize.height)];
        
        [calendarButton setTag:calendarIndex];
        
        weekday++;
        if (weekday > ASCSaturday) {
            weekday = ASCSunday;
        }
        
        dayOfMonth++;
        calendarIndex++;
    }
    
    ASCCalendarButton *restButton = (id)[self viewWithTag:calendarIndex];
    while (restButton) {
        calendarIndex++;
        [restButton removeFromSuperview];
        restButton = (id)[self viewWithTag:calendarIndex];
    }
}

- (void)onPressCalendarButton:(ASCCalendarButton *)sender
{
    [self.delegate calendarView:self onTouchUpInside:[NSDate dateWithYear:sender.year
                                                                    month:sender.month
                                                                      day:sender.dayOfCalendar]];
}
@end
