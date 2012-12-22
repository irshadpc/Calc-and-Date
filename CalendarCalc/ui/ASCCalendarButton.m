//
//  ASCCalendarButton.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/22.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "ASCCalendarButton.h"
#import "UIColor+Calendar.h"

@interface ASCCalendarButton ()
@property (strong, nonatomic) UIImage *imageForNormal;

- (void)configureTitle;
- (void)configureColor;
- (void)configureImage;
@end

@implementation ASCCalendarButton

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18.]];
        [self.titleLabel setShadowOffset:CGSizeMake(1., 1.)];

        [self setTitleShadowColor: [UIColor whiteColor]
                                   forState: UIControlStateNormal];

        [self setTitleShadowColor: [UIColor blackColor]
                                   forState: UIControlStateHighlighted];

    }
    return self;
}

- (void)setDayOfMonth:(NSInteger)dayOfMonth
{
    _dayOfMonth = dayOfMonth;
    [self configureTitle];
}

- (void)setWeekday:(NSInteger)weekday
{
    _weekday = weekday;
    [self configureColor];
}

- (void)setImage:(UIImage *)image
        forState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
            self.imageForNormal = image;
            break;
        default:
            NSLog(@"STATE: %d", state);
            abort();
    }
    [self configureImage];
}

- (void)configureTitle 
{
    [self setTitle: [NSString stringWithFormat:@"%d", self.dayOfMonth]
          forState: UIControlStateNormal];
}

- (void)configureColor
{
    if (self.weekday == 0) {
        [self setTitleColor:[UIColor otherMonthColor] forState:UIControlStateNormal];
    } else if (self.weekday == 1) {
        [self setTitleColor:[UIColor sundayColor] forState:UIControlStateNormal];
    } else if (self.weekday == 7) {
        [self setTitleColor:[UIColor saturdayColor] forState:UIControlStateNormal];
    } else {
        [self setTitleColor:[UIColor usualdayColor] forState:UIControlStateNormal];
    }
}

- (void)configureImage
{
    [self setBackgroundImage:self.imageForNormal forState:UIControlStateNormal];
}

@end
