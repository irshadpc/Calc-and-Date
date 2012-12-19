//
//  ASCCalendarControllView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/19.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "ASCCalendarControllView.h"
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

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:CGRectMake(0, 0, 44.0 * 7, 44.0)])) {
        UIButton *prevButton = [[UIButton alloc] initWithFrame:CGRectMake(6, 0, 44.0 * 2, 44.0)];
        [prevButton setImage:[UIImage imageNamed:@"prev_button"] forState:UIControlStateNormal];
        [prevButton addTarget:self action:@selector(onPrev:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prevButton];

        _dateSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(6 + 44.0 * 2, 0, 44.0 * 3, 44.0)];
        [_dateSelectButton setBackgroundImage:[UIImage imageNamed:@"date_select_button"] forState:UIControlStateNormal];
        [_dateSelectButton addTarget:self action:@selector(onDateSelect:) forControlEvents:UIControlEventTouchUpInside];
        [_dateSelectButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [_dateSelectButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self addSubview:_dateSelectButton];

        UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(6 + 44.0 * 5, 0, 44.0 * 2, 44.0)];
        [nextButton setImage:[UIImage imageNamed:@"next_button"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(onNext:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextButton];
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