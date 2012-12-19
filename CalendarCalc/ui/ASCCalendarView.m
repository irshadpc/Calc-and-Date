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
@property (nonatomic, readwrite) NSInteger year;
@property (nonatomic, readwrite) NSInteger month;

- (void)reloadCalendarView;
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
    NSDate *date = [NSDate dateWithYear: self.year
                                  month: self.month - 1
                                    day: 1];
    self.year = [date year];
    self.month = [date month];
    [self reloadCalendarView];
}

- (void)nextMonth
{
    NSDate *date = [NSDate dateWithYear: self.year
                                  month: self.month + 1
                                    day: 1];
    self.year = [date year];
    self.month = [date month];
    [self reloadCalendarView];
}

- (void)reloadCalendarViewWithYear:(NSInteger)year
                             month:(NSInteger)month
{
    if (self.year == year && self.month == month) {
        return;
    }

    self.year = year;
    self.month = month;
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
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    NSInteger subBaseY = 0;
    NSDate *startOfMonth = [NSDate dateWithYear: self.year
                                          month: self.month
                                            day: 1];
    NSDate *endOfMonth = [NSDate endOfMonthWithYear: self.year
                                              month: self.month];
    
    NSInteger firstDay = 1 - [startOfMonth weekday];
    NSInteger lastDay = [endOfMonth day] + (7 - [endOfMonth weekday]);
   
    NSInteger weekday = 1;
    NSInteger dayOfMonth = [[NSDate dateWithYear: self.year
                                           month: self.month
                                             day: firstDay] day];
    NSInteger endOfMonthDay = [endOfMonth day];
    for (NSInteger targetDay = firstDay; targetDay < lastDay; targetDay++) {
        if (targetDay == 0 || targetDay == endOfMonthDay) {
            dayOfMonth = 1;
        }
        
        UIButton *calendarButton = [[UIButton alloc] init];
        
        [calendarButton setBackgroundImage: _normalImage
                                  forState: UIControlStateNormal];
        
        [calendarButton setTitle: [NSString stringWithFormat:@"%d", dayOfMonth]
                        forState: UIControlStateNormal];
        
        [calendarButton setTag:targetDay + 1];
        
        // color
        if (targetDay < 0 || targetDay >= endOfMonthDay) {
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

        weekday++;
        if (weekday > 7) {
            weekday = 1;
        }
        
        dayOfMonth++;
    }
}

- (void)onPressCalendarButton:(UIButton *)sender
{
    [self.delegate calendarView:self onTouchUpInside:[NSDate dateWithYear: self.year
                                                                    month: self.month
                                                                      day: sender.tag]];
}

@end
