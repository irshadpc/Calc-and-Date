//
//  CalendarControllView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/19.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarControlView.h"
#import "CalendarView.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "UIFont+Calendar.h"
#import "UIImage+Calendar.h"
#import "NSString+Date.h"

@interface CalendarControlView ()
@property(strong, nonatomic, readwrite) UIButton *dateSelectButton;
@property(strong, nonatomic, readwrite) UIButton *prevButton;
@property(strong, nonatomic, readwrite) UIButton *nextButton;

- (void)onPrev:(UIButton *)sender;
- (void)onNext:(UIButton *)sender;
- (void)onDateSelect:(UIButton *)sender;
- (void)setDateSelectButtonTitle:(NSDate *)date;
- (void)setupPrevButtonWithCalendarView:(CalendarView *)calendarView;
- (void)setupNextButtonWithCalendarView:(CalendarView *)calendarView;
- (void)setupDateSelectButtonWithCalendarView:(CalendarView *)calendarView;
@end

@implementation CalendarControlView
- (id)initWithCalendarView:(CalendarView *)calendarView
{
    CGRect frame = CGRectMake(0, 0, calendarView.frame.size.width, calendarView.buttonSize.height);
    if ((self = [super initWithFrame:frame])) {
        _currentDate = [NSDate dateWithYear:calendarView.year month:calendarView.month day:1];

        [self setupPrevButtonWithCalendarView:calendarView];
        [self setupNextButtonWithCalendarView:calendarView];
        [self setupDateSelectButtonWithCalendarView:calendarView];

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


#pragma mark - Action

- (void)onPrev:(UIButton *)sender
{
    [self.delegate calendarControlView:self pressPrevMonthButton:sender];
    self.currentDate = [NSDate dateWithYear:[self.currentDate year]
                                      month:[self.currentDate month] - 1
                                        day:1];
}

- (void)onNext:(UIButton *)sender
{
    [self.delegate calendarControlView:self pressNextMonthButton:sender];
    self.currentDate = [NSDate dateWithYear:[self.currentDate year]
                                      month:[self.currentDate month] + 1
                                        day:1];
}

- (void)onDateSelect:(UIButton *)sender
{
    [self.delegate calendarControlView:self pressDateSelectButton:sender];
}


#pragma mark - Private

- (void)setDateSelectButtonTitle:(NSDate *)date
{
    [self.dateSelectButton setTitle: [NSString stringWithYear:[date year]
                                                        month:[date month]]
                           forState: UIControlStateNormal];
    self.currentDate = date;
}

- (void)setupPrevButtonWithCalendarView:(CalendarView *)calendarView
{
    _prevButton = [[UIButton alloc] initWithFrame:CGRectMake(calendarView.margin,
                                                             0,
                                                             calendarView.buttonSize.width * 2,
                                                             self.frame.size.height)];
    
    [_prevButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_prevButton setBackgroundImage:[UIImage calendarControllImage] forState:UIControlStateNormal];
    [_prevButton setImage:[UIImage prevImage] forState:UIControlStateNormal];
    [_prevButton addTarget:self action:@selector(onPrev:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupNextButtonWithCalendarView:(CalendarView *)calendarView
{
    _nextButton = [[UIButton alloc] initWithFrame:CGRectMake(calendarView.margin + (calendarView.buttonSize.width * 5),
                                                             0,
                                                             calendarView.buttonSize.width * 2,
                                                             self.frame.size.height)];
    
    [_nextButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_nextButton setBackgroundImage:[UIImage calendarControllImage] forState:UIControlStateNormal];
    [_nextButton setImage:[UIImage nextImage] forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(onNext:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupDateSelectButtonWithCalendarView:(CalendarView *)calendarView
{
    _dateSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(calendarView.margin + (calendarView.buttonSize.width * 2),
                                                                   0,
                                                                   calendarView.buttonSize.width * 3,
                                                                   self.frame.size.height)];

    [_dateSelectButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_dateSelectButton setBackgroundImage:[UIImage dateSelectImage] forState:UIControlStateNormal];
    [_dateSelectButton addTarget:self action:@selector(onDateSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_dateSelectButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_dateSelectButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dateSelectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_dateSelectButton setTitleShadowColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
    [_dateSelectButton.titleLabel setFont:[UIFont dateSelectFont]];
    [_dateSelectButton.titleLabel setShadowOffset:CGSizeMake(1., 1.)];

    [self setDateSelectButtonTitle:_currentDate];
}
@end