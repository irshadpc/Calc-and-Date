//
//  CalendarButton.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/22.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarButton.h"
#import "UIColor+Calendar.h"
#import "UIFont+Calendar.h"
#import "UIImage+Calendar.h"

@interface CalendarButton ()
- (void)configureTitle;
- (void)configureColor;
- (void)configureImage;
@end

@implementation CalendarButton
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self setTitleShadowColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
        [self.titleLabel setFont:[UIFont calendarFont]];
        [self.titleLabel setShadowOffset:CGSizeMake(1., 1.)];
    }
    return self;
}

- (void)setDayOfMonth:(NSInteger)dayOfMonth
{
    _dayOfMonth = dayOfMonth;
    [self configureTitle];
}

- (void)setWeekday:(Week)weekday
{
    _weekday = weekday;
    [self configureColor];
    [self configureImage];
}

- (void)setOtherMonthDate:(BOOL)otherMonthDate
{
    _otherMonthDate = otherMonthDate;
    [self configureColor];
}

- (void)setToday:(BOOL)today
{
    _today = today;
    [self configureImage];
    [self configureColor];
}

- (void)setHasEvent:(BOOL)hasEvent
{
    _hasEvent = hasEvent;
    [self configureImage];
}

- (void)setOn:(BOOL)on
{
    _on = on;
    [self configureImage];
    [self configureColor];
}

- (void)configureTitle
{
    [self setTitle:[NSString stringWithFormat:@"%d", self.dayOfMonth]
          forState:UIControlStateNormal];
}

- (void)configureColor
{
    if (self.isToday || self.isOn) {
        [self setTitleColor:[UIColor todayColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    } else {
        if (self.isOtherMonthDate) {
            [self setTitleColor:[UIColor otherMonthColor] forState:UIControlStateNormal];
        } else if (self.weekday == Sunday) {
            [self setTitleColor:[UIColor sundayColor] forState:UIControlStateNormal];
        } else if (self.weekday == Saturday) {
            [self setTitleColor:[UIColor saturdayColor] forState:UIControlStateNormal];
        } else {
            [self setTitleColor:[UIColor usualdayColor] forState:UIControlStateNormal];
        }
        [self setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)configureImage
{
    [self setBackgroundImage:[UIImage calendarImageWithToday:self.isToday]
                    forState:UIControlStateNormal];
}
@end