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
@property (strong, nonatomic) UIButton *dateSelectButton;


- (void)onPrev:(UIButton *)sender;
- (void)onNext:(UIButton *)sender;
- (void)onDateSelect:(UIButton *)sender;

- (void)setDateSelectButtonTitle:(NSDate *)date;
@end

@implementation ASCCalendarControllView

static const CGFloat HEIGHT = 44.0;

- (id)initWithCalendarView:(ASCCalendarView *)calendarView
{
    if ((self = [super initWithFrame:CGRectMake(0, 0, calendarView.frame.size.width, HEIGHT)])) {
        const CGFloat CalendarButtonWidth = calendarView.calendarButtonSize.width;

        UIButton *prevButton = [[UIButton alloc] initWithFrame:CGRectMake(ASCCalendarMargin,
                                                                          0,
                                                                          CalendarButtonWidth * 2,
                                                                          HEIGHT)];
        [prevButton setImage:[UIImage imageNamed:@"prev_button"] forState:UIControlStateNormal];
        [prevButton addTarget:self action:@selector(onPrev:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prevButton];


        _dateSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(ASCCalendarMargin + (CalendarButtonWidth * 2),
                                                                       0,
                                                                       CalendarButtonWidth * 3,
                                                                       HEIGHT)];
        [_dateSelectButton setBackgroundImage:[UIImage imageNamed:@"date_select_button"] forState:UIControlStateNormal];
        [_dateSelectButton addTarget:self action:@selector(onDateSelect:) forControlEvents:UIControlEventTouchUpInside];
        [_dateSelectButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [_dateSelectButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_dateSelectButton setTitle:[NSString stringWithYear:calendarView.year month:calendarView.month] forState:UIControlStateNormal];
        [self addSubview:_dateSelectButton];


        UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(ASCCalendarMargin + CalendarButtonWidth * 5,
                                                                          0,
                                                                          CalendarButtonWidth * 2,
                                                                          HEIGHT)];
        [nextButton setImage:[UIImage imageNamed:@"next_button"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(onNext:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextButton];

        _currentDate = [NSDate dateWithYear:calendarView.year month:calendarView.month day:1];
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
    [self setDateSelectButtonTitle:[self.delegate calendarControllView:self pressDateSelectButton:sender]];
}

- (void)setDateSelectButtonTitle:(NSDate *)date
{
    [self.dateSelectButton setTitle: [NSString stringWithYear: [date year]
                                                        month: [date month]]
                           forState: UIControlStateNormal];
    self.currentDate = date;
}

@end