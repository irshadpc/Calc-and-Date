//
//  ASCCalendarControllView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/19.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "ASCCalendarControllView.h"
#import "ASCCalendarConstant.h"
#import "ASCCalendarView.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "NSString+Date.h"

@interface ASCCalendarControllView ()
@property (strong, nonatomic, readwrite) UIButton *dateSelectButton;
@property (strong, nonatomic, readwrite) UIButton *prevButton;
@property (strong, nonatomic, readwrite) UIButton *nextButton;

- (void)onPrev:(UIButton *)sender;
- (void)onNext:(UIButton *)sender;
- (void)onDateSelect:(UIButton *)sender;

- (void)setDateSelectButtonTitle:(NSDate *)date;

- (void)setupPrevButtonWithCalendarButtonWidth:(CGFloat)calendarButtonWidth;
- (void)setupNextButtonWithCalendarButtonWidth:(CGFloat)calendarButtonWidth;;
- (void)setupDateSelectButtonWithCalendarButtonWidth:(CGFloat)calendarButtonWidth;;
@end

@implementation ASCCalendarControllView

- (id)initWithCalendarView:(ASCCalendarView *)calendarView
{
    CGRect frame = CGRectMake(0, 0, calendarView.frame.size.width, calendarView.calendarButtonSize.height);
    if ((self = [super initWithFrame:frame])) {
        _currentDate = [NSDate dateWithYear:calendarView.year month:calendarView.month day:1];

        const CGFloat CalendarButtonWidth = calendarView.calendarButtonSize.width;
        [self setupPrevButtonWithCalendarButtonWidth:CalendarButtonWidth];
        [self setupNextButtonWithCalendarButtonWidth:CalendarButtonWidth];
        [self setupDateSelectButtonWithCalendarButtonWidth:CalendarButtonWidth];

        [self addSubview:_prevButton];
        [self addSubview:_nextButton];
        [self addSubview:_dateSelectButton];
    }
    return self;
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    if (_currentDate == currentDate) {
        return;
    }
    _currentDate = currentDate;
    [self setDateSelectButtonTitle:_currentDate];
}


#pragma mark - Private

- (void)onPrev:(UIButton *)sender
{
    [self setDateSelectButtonTitle:[self.delegate calendarControllView:self pressPrevMonthButton:sender]];
}

- (void)onNext:(UIButton *)sender
{
    [self setDateSelectButtonTitle:[self.delegate calendarControllView:self pressNextMonthButton:sender]];
}

- (void)onDateSelect:(UIButton *)sender
{
    [self.delegate calendarControllView:self pressDateSelectButton:sender];
}

- (void)setDateSelectButtonTitle:(NSDate *)date
{
    [self.dateSelectButton setTitle: [NSString stringWithYear: [date year]
                                                        month: [date month]]
                           forState: UIControlStateNormal];
    self.currentDate = date;
}

- (void)setupPrevButtonWithCalendarButtonWidth:(CGFloat)calendarButtonWidth
{
    _prevButton = [[UIButton alloc] initWithFrame:CGRectMake(ASCCalendarMargin,
                                                             0,
                                                             calendarButtonWidth * 2,
                                                             self.frame.size.height)];
    [_prevButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_prevButton setImage:[UIImage imageNamed:@"prev_button"] forState:UIControlStateNormal];
    [_prevButton addTarget:self action:@selector(onPrev:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupNextButtonWithCalendarButtonWidth:(CGFloat)calendarButtonWidth
{
    _nextButton = [[UIButton alloc] initWithFrame:CGRectMake(ASCCalendarMargin + calendarButtonWidth * 5,
                                                             0,
                                                             calendarButtonWidth * 2,
                                                             self.frame.size.height)];
    [_nextButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_nextButton setImage:[UIImage imageNamed:@"next_button"] forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(onNext:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupDateSelectButtonWithCalendarButtonWidth:(CGFloat)calendarButtonWidth
{
    _dateSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(ASCCalendarMargin + (calendarButtonWidth * 2),
                                                                   0,
                                                                   calendarButtonWidth * 3,
                                                                   self.frame.size.height)];
    [_dateSelectButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_dateSelectButton setBackgroundImage:[UIImage imageNamed:@"date_select_button"] forState:UIControlStateNormal];
    [_dateSelectButton addTarget:self action:@selector(onDateSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_dateSelectButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    [_dateSelectButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [self setDateSelectButtonTitle:_currentDate];
}

@end