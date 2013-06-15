//
//  NSDate+Component.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDate+Component.h"

@implementation NSDate (Component)
- (NSInteger)year
{
    return [[[NSCalendar currentCalendar] components:NSYearCalendarUnit
                                            fromDate:self] year];
}

- (NSInteger)month
{
    return [[[NSCalendar currentCalendar] components:NSMonthCalendarUnit
                                            fromDate:self] month];
}

- (NSInteger)day
{
    return [[[NSCalendar currentCalendar] components:NSDayCalendarUnit
                                            fromDate:self] day];
}

- (NSInteger)weekday
{
    return [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit
                                            fromDate:self] weekday];
}
@end
