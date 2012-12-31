//
//  CCWeekControllView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCWeekControllView.h"
#import "ASCCalendarView.h"
#import "ASCSwitchButton.h"
#import "ASCWeek.h"
#import "NSString+Week.h"
#import "UIFont+Calendar.h"
#import "ASCCalendarConstant.h"

@interface CCWeekControllView () {
  @private
    CGSize _buttonSize;
}
- (ASCSwitchButton *)weekButton:(NSInteger)week;
- (CGRect)weekButtonFrame:(NSInteger)week;
- (void)onWeekButton:(ASCSwitchButton *)sender;
@end

@implementation CCWeekControllView

- (id)initWithCalendarView:(ASCCalendarView *)calendarView
{
    CGRect frame = CGRectMake(calendarView.frame.origin.x,
                              0,
                              calendarView.frame.size.width,
                              44.0);
    if ((self = [super initWithFrame:frame])) {
        _buttonSize = calendarView.calendarButtonSize;
        
        [self addSubview:[self weekButton:ASCSunday]];
        [self addSubview:[self weekButton:ASCMonday]];
        [self addSubview:[self weekButton:ASCTuesday]];
        [self addSubview:[self weekButton:ASCWednesday]];
        [self addSubview:[self weekButton:ASCThursday]];
        [self addSubview:[self weekButton:ASCFriday]];
        [self addSubview:[self weekButton:ASCSaturday]];
    }
    return self;
}

#pragma mark - Private

- (ASCSwitchButton *)weekButton:(NSInteger)week
{
    ASCSwitchButton *weekButton = [[ASCSwitchButton alloc] initWithFrame:[self weekButtonFrame:week]];
    [weekButton setTitle:[NSString stringWithWeek:week] forState:UIControlStateNormal];
    [weekButton.titleLabel setFont:[UIFont calendarFont]];
    [weekButton addTarget:self action:@selector(onWeekButton:) forControlEvents:UIControlEventTouchUpInside];
    [weekButton setTag:week];
    [weekButton setOn:YES];
    return weekButton;
}

- (CGRect)weekButtonFrame:(NSInteger)week
{
    return CGRectMake(ASCCalendarMargin + ((week - 1) * _buttonSize.width),
                      0,
                      _buttonSize.width,
                      _buttonSize.height);
}

- (void)onWeekButton:(ASCSwitchButton *)sender
{
    sender.on = !sender.on;
    [self.delegate weekControllView:self week:sender.tag on:sender.on];
}

@end
