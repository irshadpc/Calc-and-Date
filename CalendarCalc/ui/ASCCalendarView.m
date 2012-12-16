//
//  ASCCalendarView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "ASCCalendarView.h"
#import "UIColor+Calendar.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"

@interface ASCCalendarView ()
- (void)reloadCalendarView;
- (void)onPressCalendarButton:(UIButton *)sender;
@end

@implementation ASCCalendarView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        NSDate *date = [NSDate date];
        _year = [date year];
        _month = [date month];
    }
    return self;
}

- (void)prevMonth
{
    _month--;
    [self reloadCalendarView];
}

- (void)nextMonth
{
    _month++;
    [self reloadCalendarView];
}

- (void)reloadCalendarViewWithYear:(NSInteger)year
                             month:(NSInteger)month
{
    if (_year == year && _month == month) {
        return;
    }

    _year = year;
    _month = month;
    [self reloadCalendarView];
}


#pragma mark - Private

- (void)reloadCalendarView
{
    NSInteger firstDay = 1 - [[NSDate dateWithYear: _year
                                             month: _month
                                               day: 1] weekday];

    NSDate *endOfMonth = [NSDate endOfMonthWithYear: _year
                                              month: _month];

    NSInteger lastDay = [endOfMonth day] + (7 - [endOfMonth weekday]);


    NSInteger subBaseY = 0;
    for (NSInteger targetDay = firstDay; targetDay < lastDay; targetDay++) {
        NSDate *targetDate = [NSDate dateWithYear: _year
                                            month: _month
                                              day: targetDay + 1];

        UIButton *calendarButton = [[UIButton alloc] init];
        NSInteger weekday = [targetDate weekday];

        // color
        if ([targetDate month] != _month){
            [calendarButton setTitleColor:[UIColor otherMonthColor] forState:UIControlStateNormal];
        } else if (weekday == 1) {
            [calendarButton setTitleColor:[UIColor sundayColor] forState:UIControlStateNormal];
        } else if (weekday == 7) {
            [calendarButton setTitleColor:[UIColor saturdayColor] forState:UIControlStateNormal];
        } else {
            [calendarButton setTitleColor:[UIColor usualdayColor] forState:UIControlStateNormal];
        }
        [calendarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        // font
        [calendarButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.]];

        [calendarButton setTitleShadowColor: [UIColor whiteColor]
                                   forState: UIControlStateNormal];

        [calendarButton setTitleShadowColor: [UIColor blackColor]
                                   forState: UIControlStateHighlighted];
        
        [calendarButton.titleLabel setShadowOffset:CGSizeMake(1., 1.)];
        [calendarButton setSelected:NO];

        // position
        if (weekday == 1) {
            subBaseY++;
        }

        static const CGFloat MARGIN = 6.0;
        static const CGFloat CALENDAR_WIDTH = 44.0;
        static const CGFloat CALENDAR_HEIGHT = 44.0;
        [calendarButton setFrame:CGRectMake(MARGIN + (CALENDAR_WIDTH * (weekday - 1)),
                                            CALENDAR_HEIGHT * (subBaseY - 1),
                                            CALENDAR_WIDTH,
                                            CALENDAR_HEIGHT)];

        [calendarButton setTag:targetDay + 1];

        [calendarButton setTitle: [NSString stringWithFormat:@"%d", [targetDate day]]
                        forState: UIControlStateNormal];

        [calendarButton addTarget: self
                           action: @selector(onPressCalendarButton:)
                 forControlEvents: UIControlEventTouchUpInside];
        
        [self addSubview:calendarButton];
    }
}

- (void)onPressCalendarButton:(UIButton *)sender
{
    [self.delegate calendarView:self onTouchUpInside:[NSDate dateWithYear: _year
                                                                    month: _month
                                                                      day: sender.tag]];
}

@end
