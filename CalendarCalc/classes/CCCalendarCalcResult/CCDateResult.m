//
//  CCDateResult.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCDateResult.h"
#import "NSDateFormatter+CalendarCalc.h"

@implementation CCDateResult

+ (NSDate *)dateFromString:(NSString *)string
{
    if (![[NSDateFormatter yyyymmddFormatter] isDate:string]) {
        return nil;
    }
    return [[NSDateFormatter yyyymmddFormatter] dateFromString:string];
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    return [[NSDateFormatter yyyymmddFormatter] stringFromDate:date];
}

- (void)clear
{
    _date = nil;
}

- (NSDate *)result
{
    return _date;
}

- (void)setResult:(NSDate *)date
{
    return [self inputDate:date];
}

- (void)inputDate:(NSDate *)date
{
    _date = date;
}

- (NSString *)displayResult
{
    return [[NSDateFormatter yyyymmddFormatter] stringFromDate:_date];
}

@end
