//
//  CCCalendarCalcResult+Date.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcResult+Date.h"
#import "NSDateFormatter+CalendarCalc.h"

@interface CCCalendarCalcResult (DatePrivate)

@end

@implementation CCCalendarCalcResult (Date)

- (NSDate *)dateResult
{
    return _date;
}

- (CCCalendarCalcResult *)setDateResult:(NSDate *)date
{
    return [self inputDate:date];
}

- (CCCalendarCalcResult *)inputDate:(NSDate *)date
{
    _date = date;
    [_string setString: [[NSDateFormatter yyyymmddFormatter] stringFromDate: date]];

    return self;
}

@end

@implementation CCCalendarCalcResult (DatePrivate)

@end