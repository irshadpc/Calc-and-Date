//
//  CalendarControllView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/19.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarControlView.h"
#import "CalendarView.h"
#import "AppDelegate.h"
#import "NSDate+ConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "UIFont+CalendarCalc.h"
#import "UIImage+CalendarCalc.h"
#import "NSString+CalendarCalc.h"

@interface CalendarControlView ()
@property(strong, nonatomic, readwrite) UIButton *dateSelectButton;
@property(strong, nonatomic, readwrite) UIButton *prevButton;
@property(strong, nonatomic, readwrite) UIButton *nextButton;
@property(weak, nonatomic) AVAudioPlayer *player;

- (void)onPrev:(UIButton *)sender;
- (void)onNext:(UIButton *)sender;
- (void)onDateSelect:(UIButton *)sender;
- (void)onClick:(UIButton *)sender;
- (void)configurePrevNextButton;
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
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _player = [(AppDelegate *)[[UIApplication sharedApplication] delegate] player];
        }
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

- (void)setStringTitleMode:(BOOL)stringTitleMode
{
    _stringTitleMode = stringTitleMode;
    [self configurePrevNextButton];
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

- (void)onClick:(UIButton *)sender
{
    [self.player setCurrentTime:0];
    [self.player play];
}


#pragma mark - Private

- (void)configurePrevNextButton
{
    if (self.isStringTitleMode) {
        [self.nextButton setTitle:NSLocalizedString(@"NEXT_MONTH", nil) forState:UIControlStateNormal];
        [self.prevButton setTitle:NSLocalizedString(@"PREV_MONTH", nil) forState:UIControlStateNormal];
        [self.nextButton setImage:nil forState:UIControlStateNormal];
        [self.prevButton setImage:nil forState:UIControlStateNormal];
    } else {
        [self.nextButton setTitle:nil forState:UIControlStateNormal];
        [self.prevButton setTitle:nil forState:UIControlStateNormal];
        [self.nextButton setImage:[UIImage nextImage] forState:UIControlStateNormal];
        [self.prevButton setImage:[UIImage prevImage] forState:UIControlStateNormal];
    }
}

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
    [_prevButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_prevButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_prevButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_prevButton setTitleShadowColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
    [_prevButton.titleLabel setFont:[UIFont dateSelectFont]];
    [_prevButton.titleLabel setShadowOffset:CGSizeMake(1., 1.)];
    [_prevButton addTarget:self action:@selector(onPrev:) forControlEvents:UIControlEventTouchUpInside];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [_prevButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchDown];
    }
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
    [_nextButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_nextButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_nextButton setTitleShadowColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
    [_nextButton.titleLabel setFont:[UIFont dateSelectFont]];
    [_nextButton.titleLabel setShadowOffset:CGSizeMake(1., 1.)];
    [_nextButton addTarget:self action:@selector(onNext:) forControlEvents:UIControlEventTouchUpInside];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [_nextButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchDown];
    }
}

- (void)setupDateSelectButtonWithCalendarView:(CalendarView *)calendarView
{
    _dateSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(calendarView.margin + (calendarView.buttonSize.width * 2),
                                                                   0,
                                                                   calendarView.buttonSize.width * 3,
                                                                   self.frame.size.height)];

    [_dateSelectButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_dateSelectButton setBackgroundImage:[UIImage dateSelectImage] forState:UIControlStateNormal];
    [_dateSelectButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_dateSelectButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dateSelectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_dateSelectButton setTitleShadowColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
    [_dateSelectButton.titleLabel setFont:[UIFont dateSelectFont]];
    [_dateSelectButton.titleLabel setShadowOffset:CGSizeMake(1., 1.)];
    [_dateSelectButton addTarget:self action:@selector(onDateSelect:) forControlEvents:UIControlEventTouchUpInside];

    [self setDateSelectButtonTitle:_currentDate];
}
@end