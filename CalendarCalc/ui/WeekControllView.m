//
//  CCWeekControllView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "WeekControllView.h"
#import "CalendarView.h"
#import "SwitchButton.h"
#import "NSString+Week.h"
#import "UIFont+Calendar.h"
#import "CalendarConstant.h"
#import "Week.h"

@interface WeekControllView ()
- (SwitchButton *)weekButton:(Week)week size:(CGSize)size;
- (CGRect)weekButtonFrame:(Week)week size:(CGSize)size;
- (void)onWeekButton:(SwitchButton *)sender;
@end

@implementation WeekControllView
- (id)initWithCalendarView:(CalendarView *)calendarView
{
    const CGRect frame = CGRectMake(calendarView.frame.origin.x,
                                    0,
                                    calendarView.frame.size.width,
                                    calendarView.buttonSize.height);

    if ((self = [super initWithFrame:frame])) {
        const CGSize buttonSize = calendarView.buttonSize;
        [self addSubview:[self weekButton:Sunday size:buttonSize]];
        [self addSubview:[self weekButton:Monday size:buttonSize]];
        [self addSubview:[self weekButton:Tuesday size:buttonSize]];
        [self addSubview:[self weekButton:Wednesday size:buttonSize]];
        [self addSubview:[self weekButton:Thursday size:buttonSize]];
        [self addSubview:[self weekButton:Friday size:buttonSize]];
        [self addSubview:[self weekButton:Saturday size:buttonSize]];
    }
    return self;
}


#pragma mark - Private

- (SwitchButton *)weekButton:(Week)week size:(CGSize)size
{
    SwitchButton *weekButton = [[SwitchButton alloc] initWithFrame:[self weekButtonFrame:week size:size]];
    [weekButton setTitle:[NSString stringWithWeek:week] forState:UIControlStateNormal];
    [weekButton.titleLabel setFont:[UIFont calendarFont]];
    [weekButton addTarget:self action:@selector(onWeekButton:) forControlEvents:UIControlEventTouchUpInside];
    [weekButton setTag:week];
    [weekButton setOn:YES];
    return weekButton;
}

- (CGRect)weekButtonFrame:(Week)week size:(CGSize)size
{
    return CGRectMake(CalendarMargin + ((week - 1) * size.width),
                      0,
                      size.width,
                      size.height);
}

- (void)onWeekButton:(SwitchButton *)sender
{
    sender.on = !sender.on;
    [self.delegate weekControllView:self week:sender.tag on:sender.on];
}
@end