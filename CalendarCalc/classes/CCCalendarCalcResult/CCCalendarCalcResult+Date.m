//
//  CCCalendarCalcResult+Date.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcResult+Date.h"
#import "CCDateResult.h"
#import "NSDateFormatter+CalendarCalc.h"

@implementation CCCalendarCalcResult (Date)

- (NSDate *)dateResult
{
    if (_calcType != CCDate) {
        return nil;
    }
    
    return [_dateResult result];
}

- (void)setDateResult:(NSDate *)date
{
    if (!date) {
        return;
    }

    _calcType = CCDate;
    [_dateResult setResult:date];
    [self updateDisplayResult];
}

- (void)setDateResultForDisplay:(NSDate *)date
{
    if (!date) {
        return;
    }
    _displayResult = [[NSDateFormatter yyyymmddFormatter] stringFromDate:date];
}

- (CCCalendarCalcResult *)inputDate:(NSDate *)date
{
    [_dateResult inputDate:date];
    _calcType = CCDate;
    [self updateDisplayResult];
    
    return self;
}

@end
