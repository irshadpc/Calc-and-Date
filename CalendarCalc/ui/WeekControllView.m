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
#import "Week.h"
#import "NSString+Week.h"
#import "UIFont+Calendar.h"
#import "CalendarConstant.h"

@interface WeekControllView () {
  @private
    CGSize _buttonSize;
}
- (SwitchButton *)weekButton:(NSInteger)week;
- (CGRect)weekButtonFrame:(NSInteger)week;
- (void)onWeekButton:(SwitchButton *)sender;
@end

@implementation WeekControllView

- (id)initWithCalendarView:(CalendarView *)calendarView
{
    CGRect frame = CGRectMake(calendarView.frame.origin.x,
                              0,
                              calendarView.frame.size.width,
                              calendarView.calendarButtonSize.height);
    if ((self = [super initWithFrame:frame])) {
        _buttonSize = calendarView.calendarButtonSize;
        
        [self addSubview:[self weekButton:Sunday]];
        [self addSubview:[self weekButton:Monday]];
        [self addSubview:[self weekButton:Tuesday]];
        [self addSubview:[self weekButton:Wednesday]];
        [self addSubview:[self weekButton:Thursday]];
        [self addSubview:[self weekButton:Friday]];
        [self addSubview:[self weekButton:Saturday]];
    }
    return self;
}

#pragma mark - Private

- (SwitchButton *)weekButton:(NSInteger)week
{
    SwitchButton *weekButton = [[SwitchButton alloc] initWithFrame:[self weekButtonFrame:week]];
    [weekButton setTitle:[NSString stringWithWeek:week] forState:UIControlStateNormal];
    [weekButton.titleLabel setFont:[UIFont calendarFont]];
    [weekButton addTarget:self action:@selector(onWeekButton:) forControlEvents:UIControlEventTouchUpInside];
    [weekButton setTag:week];
    [weekButton setOn:YES];
    return weekButton;
}

- (CGRect)weekButtonFrame:(NSInteger)week
{
    return CGRectMake(CalendarMargin + ((week - 1) * _buttonSize.width),
                      0,
                      _buttonSize.width,
                      _buttonSize.height);
}

- (void)onWeekButton:(SwitchButton *)sender
{
    sender.on = !sender.on;
    [self.delegate weekControllView:self week:sender.tag on:sender.on];
}

@end
