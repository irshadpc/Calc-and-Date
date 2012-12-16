//
//  ASCCalendarView.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "ASCCalendarView.h"
#import "UIColor+Calendar.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"

@interface ASCCalendarView ()
- (void)reloadCalendarView;
- (NSInteger)firstDay;
- (NSInteger)lastDay;

- (void)onPressCalendarButton:(UIButton *)sender;
@end


@implementation ASCCalendarView

static const CGFloat MARGIN = 6.0;

- (id)initWithFrame:(CGRect)frame
{
    static const CGFloat DefaultSize = 44.0;
    if ((self = [super initWithFrame:CGRectMake(frame.origin.x,
                                                frame.origin.y,
                                                (DefaultSize * 7) + MARGIN,
                                                (DefaultSize * 6) + MARGIN)])) {
        NSDate *date = [NSDate date];
        _year = [date year];
        _month = [date month];
        _calendarButtonSize = CGSizeMake(DefaultSize, DefaultSize);
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self reloadCalendarView];
}

- (void)setCalendarButtonSize:(CGSize)calendarButtonSize
{
    if (CGSizeEqualToSize(_calendarButtonSize, calendarButtonSize)) {
        return;
    }
    _calendarButtonSize = calendarButtonSize;

    CGRect newFrame = self.frame;
    newFrame.size.width = _calendarButtonSize.width * 7;
    newFrame.size.height = _calendarButtonSize.height * 6;
    self.frame = newFrame;

    [self reloadCalendarView];
}

- (void)prevMonth
{
    _month--;
    [self reloadCalendarView];
}

- (void)nextMonth
{
    _month++;
    [self reloadCalendarView];
}

- (void)reloadCalendarViewWithYear:(NSInteger)year
                             month:(NSInteger)month
{
    if (_year == year && _month == month) {
        return;
    }

    _year = year;
    _month = month;
    [self reloadCalendarView];
}

- (void)setImage:(UIImage *)image 
        forState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
            _normalImage = image;
            break;
        default:
            NSLog(@"STATE: %d", state);
            abort();
    }
}


#pragma mark - Private

- (void)reloadCalendarView
{
    NSInteger subBaseY = 0;
    for (NSInteger targetDay = [self firstDay]; targetDay < [self lastDay]; targetDay++) {
        NSDate *targetDate = [NSDate dateWithYear: _year
                                            month: _month
                                              day: targetDay + 1];
        NSInteger weekday = [targetDate weekday];

        UIButton *calendarButton = [[UIButton alloc] init];
        
        [calendarButton setBackgroundImage: _normalImage
                                  forState: UIControlStateNormal];
        
        [calendarButton setTitle: [NSString stringWithFormat:@"%d", [targetDate day]]
                        forState: UIControlStateNormal];
        
        [calendarButton setTag:targetDay + 1];
        
        // color
        if ([targetDate month] != _month){
            [calendarButton setTitleColor:[UIColor otherMonthColor] forState:UIControlStateNormal];
        } else if (weekday == 1) {
            [calendarButton setTitleColor:[UIColor sundayColor] forState:UIControlStateNormal];
        } else if (weekday == 7) {
            [calendarButton setTitleColor:[UIColor saturdayColor] forState:UIControlStateNormal];
        } else {
            [calendarButton setTitleColor:[UIColor usualdayColor] forState:UIControlStateNormal];
        }
        [calendarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        // font
        [calendarButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.]];

        [calendarButton setTitleShadowColor: [UIColor whiteColor]
                                   forState: UIControlStateNormal];

        [calendarButton setTitleShadowColor: [UIColor blackColor]
                                   forState: UIControlStateHighlighted];
        
        [calendarButton.titleLabel setShadowOffset:CGSizeMake(1., 1.)];

        // position
        if (weekday == 1) {
            subBaseY++;
        }

        [calendarButton setFrame:CGRectMake(MARGIN + (self.calendarButtonSize.width * (weekday - 1)),
                                            self.calendarButtonSize.height * (subBaseY - 1),
                                            self.calendarButtonSize.width,
                                            self.calendarButtonSize.height)];

        [calendarButton addTarget: self
                           action: @selector(onPressCalendarButton:)
                 forControlEvents: UIControlEventTouchUpInside];
        
        [self addSubview:calendarButton];
    }
}

- (NSInteger)firstDay
{
   return 1 - [[NSDate dateWithYear: _year
                              month: _month
                                day: 1] weekday];
}

- (NSInteger)lastDay
{
    NSDate *endOfMonth = [NSDate endOfMonthWithYear: _year
                                              month: _month];

    return [endOfMonth day] + (7 - [endOfMonth weekday]);
}

- (void)onPressCalendarButton:(UIButton *)sender
{
    [self.delegate calendarView:self onTouchUpInside:[NSDate dateWithYear: _year
                                                                    month: _month
                                                                      day: sender.tag]];
}

@end
