//
//  NSDate+Calc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDate+Calc.h"

@implementation NSDate (Calc)
static const NSCalendarUnit CALENDAR_UNIT_YMD = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

- (NSDate *)addingByYear:(NSInteger)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *ymdComponents = [calendar components:CALENDAR_UNIT_YMD
                                                  fromDate:self];

    [ymdComponents setYear:[ymdComponents year] + year];
    return [calendar dateFromComponents:ymdComponents];
}

- (NSDate *)addingByDay:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *ymdComponents = [calendar components:CALENDAR_UNIT_YMD
                                                  fromDate:self];

    [ymdComponents setDay:[ymdComponents day] + day];
    return [calendar dateFromComponents:ymdComponents];
}

- (NSInteger)dayIntervalWithDate:(NSDate *)date
{
    return [date timeIntervalSinceDate:self] / 60 / 60 / 24;
}
@end
