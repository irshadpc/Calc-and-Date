//
//  CCCalendarCalcResult+Date.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcResult+Date.h"
#import "DateResult.h"

@implementation CalendarCalcResult (Date)

+ (NSDate *)dateFromString:(NSString *)string
{
    return [DateResult dateFromString:string];
}

- (NSDate *)dateResult
{
    if (_calcType != CalcTypeDate) {
        return nil;
    }
    
    return [_dateResult result];
}

- (void)setDateResult:(NSDate *)date
{
    if (!date) {
        return;
    }

    _calcType = CalcTypeDate;
    [_dateResult setResult:date];
    [self updateDisplayResult];
}

- (void)setDateResultForDisplay:(NSDate *)date
{
    if (!date) {
        return;
    }
    _displayResult = [DateResult stringFromDate:date];
}

- (CalendarCalcResult *)inputDate:(NSDate *)date
{
    [_dateResult inputDate:date];
    _calcType = CalcTypeDate;
    [self updateDisplayResult];
    
    return self;
}

@end
