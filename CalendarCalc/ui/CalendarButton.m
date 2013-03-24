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
#import "Week.h"

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

        [self.titleLabel setFont:[UIFont calendarFont]];
        [self.titleLabel setShadowOffset:CGSizeMake(1., 1.)];

        [self setTitleShadowColor:[UIColor whiteColor]
                                  forState: UIControlStateNormal];

        [self setTitleShadowColor:[UIColor darkTextColor]
                                  forState: UIControlStateHighlighted];
        
    }
    return self;
}

- (void)setDayOfMonth:(NSInteger)dayOfMonth
{
    _dayOfMonth = dayOfMonth;
    [self configureTitle];
}

- (void)setWeekday:(NSInteger)weekday
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

- (void)configureTitle 
{
    [self setTitle: [NSString stringWithFormat:@"%d", self.dayOfMonth]
          forState: UIControlStateNormal];
}

- (void)configureColor
{
    if (self.isOtherMonthDate) {
        [self setTitleColor:[UIColor otherMonthColor] forState:UIControlStateNormal];
    } else if (self.weekday == Sunday) {
        [self setTitleColor:[UIColor sundayColor] forState:UIControlStateNormal];
    } else if (self.weekday == Saturday) {
        [self setTitleColor:[UIColor saturdayColor] forState:UIControlStateNormal];
    } else {
        [self setTitleColor:[UIColor usualdayColor] forState:UIControlStateNormal];
    }
}

- (void)configureImage
{
    if (self.weekday == Sunday) {
        [self setBackgroundImage:[UIImage calendarImageForSunday] forState:UIControlStateNormal];
    } else if (self.weekday == Saturday) {
        [self setBackgroundImage:[UIImage calendarImageForSaturday] forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[UIImage calendarImage] forState:UIControlStateNormal];
    }
}

@end
