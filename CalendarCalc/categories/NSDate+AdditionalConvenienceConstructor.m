//
//  NSDate+AdditionalConvenienceConstructor.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDate+AdditionalConvenienceConstructor.h"

@implementation NSDate (AdditionalConvenienceConstructor)
+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = hour;
    components.minute = minute;
    components.second = second;

    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
{
    return [self dateWithYear: year
                        month: month
                          day: day
                         hour: 0
                       minute: 0
                       second: 0];
}

+ (NSDate *)endOfMonthWithYear:(NSInteger)year
                         month:(NSInteger)month
{
    return [self dateWithYear: year
                        month: month + 1
                          day: 0
                         hour: 0
                       minute: 0
                       second: 0];
}
@end
