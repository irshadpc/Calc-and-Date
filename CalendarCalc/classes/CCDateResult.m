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
