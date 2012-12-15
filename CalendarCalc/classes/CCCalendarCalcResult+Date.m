//
//  CCCalendarCalcResult+Date.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcResult+Date.h"
#import "CCDateResult.h"

@implementation CCCalendarCalcResult (Date)

- (NSDate *)dateResult
{
    if (_isNumberResult) {
        return nil;
    }
    
    return [_dateResult result];
}

- (void)setDateResult:(NSDate *)date
{
    [_dateResult setResult:date];
    [self updateDisplayResult];
}

- (CCCalendarCalcResult *)inputDate:(NSDate *)date
{
    [_dateResult inputDate:date];
    _isNumberResult = NO;
    _isEmpty = NO;

    return self;
}

@end
