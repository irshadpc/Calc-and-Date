//
//  CCCalendarCalc+Date.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCDateCalculator.h"
#import "CCAppDelegate+Setting.h"
#import "NSDate+Calc.h"
#import "NSDate+Component.h"
#import "NSDate+Style.h"
#import "NSDecimalNumber+Calc.h"
#import "NSDecimalNumber+Convert.h"
#import "NSNumber+Predicate.h"
#import "ASCWeek.h"

typedef enum {
    CCNone,
    CCPlus,
    CCMinus,
    CCMultiply,
    CCDivide,
} CCDateFunction;

@interface CCDateCalculator () {
  @private
    CCDateFunction _function;
    NSDecimalNumber *_tmpOperand;
}
- (NSDate *)calcWithNumber:(NSDecimalNumber *)rOperand function:(CCDateFunction)function;
- (NSDecimalNumber *)calcWithDate:(NSDate *)rOperand function:(CCDateFunction)function;
- (void)cacheWithNumber:(NSDecimalNumber *)rOperand;
- (void)cacheWithDate:(NSDate *)rOperand function:(CCDateFunction)function;
- (void)updateDateResult:(NSDate *)result function:(CCDateFunction)function;
- (NSDecimalNumber *)excludeDayCountWithStartDate:(NSDate *)startDate
                                          endDate:(NSDate *)endDate;
@end


@implementation CCDateCalculator

////////////////////////////////////////////////////////////////////////////////
- (void)clear
{
    _numberResult = nil;
    _dateResult = nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)plusWithNumber:(NSDecimalNumber *)rOperand 
{
    return [self calcWithNumber:rOperand function:CCPlus];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)plusWithDate:(NSDate *)rOperand 
{
    return [self calcWithDate:rOperand function:CCPlus];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)minusWithNumber:(NSDecimalNumber *)rOperand 
{
    return [self calcWithNumber:rOperand function:CCMinus];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)minusWithDate:(NSDate *)rOperand 
{
    return [self calcWithDate:rOperand function:CCMinus];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)multiplyWithNumber:(NSDecimalNumber *)rOperand
{
    [self cacheWithNumber:rOperand];
    return nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)multiplyWithDate:(NSDate *)rOperand
{
    [self cacheWithDate:rOperand function:CCMultiply];
    return nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)divideWithNumber:(NSDecimalNumber *)rOperand
{
    [self cacheWithNumber:rOperand];
    return nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)divideWithDate:(NSDate *)rOperand
{
    [self cacheWithDate:rOperand function:CCDivide];
    return nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)reverse
{
    if (!_numberResult) {
        return nil;
    }
    _numberResult = [NSDecimalNumber reverse:_numberResult];
    return _numberResult;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)setDateRusult:(NSDate *)result
{
    if (!result) {
        return nil;
    }
    _isDateResult = YES;
    _dateResult = [result noTime];
    return _dateResult;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)setNumberResult:(NSDecimalNumber *)result
{
    if (!result) {
        return nil;
    }
    
    _isDateResult = NO;
    _numberResult = result;
    return _numberResult;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)dateResult
{
    return _isDateResult ? _dateResult : nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)numberResult
{
    return _isDateResult ? nil : _numberResult;
}



#pragma mark - Private
////////////////////////////////////////////////////////////////////////////////
- (NSDate *)calcWithNumber:(NSDecimalNumber *)rOperand 
                  function:(CCDateFunction)function
{
    if (!rOperand || !_dateResult) {
        return nil;
    }

    NSInteger addingDay = 0;
    switch (function) {
        case CCPlus:
            addingDay = rOperand.integerValue;
            break;
        case CCMinus:
            addingDay = -rOperand.integerValue;
            break;
        case CCMultiply:
        case CCDivide:
        default:
            NSLog(@"FUNCTION: %d", function);
            abort();
    }

    return [self setDateRusult:[_dateResult addingByDay:addingDay]];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)calcWithDate:(NSDate *)rOperand 
                         function:(CCDateFunction)function
{
    if (!rOperand) {
        return nil;
    }

    if (!_dateResult) {
        [self updateDateResult:rOperand function:function];
        return nil;
    }

    NSDate *lOperand = nil;
     if ([(CCAppDelegate *)[[UIApplication sharedApplication] delegate] includeStartDayOption]) {
         lOperand = [_dateResult addingByDay:-1];
     } else {
         lOperand = _dateResult;
     }

    _isDateResult = NO;
    _numberResult = [NSDecimalNumber decimalNumberWithString:@([lOperand dayIntervalWithDate:[rOperand noTime]]).stringValue];

    if ([_numberResult isMinus]) {
        _numberResult = [NSDecimalNumber reverse:_numberResult];
    }

    _numberResult = [NSDecimalNumber subtractingByDecimalNumber:_numberResult
                                                       rOperand:[self excludeDayCountWithStartDate:lOperand
                                                                                           endDate:[rOperand noTime]]];

    if ((function == CCPlus && [_numberResult isMinus]) || (function == CCMinus && ![_numberResult isMinus])) {
        _numberResult = [NSDecimalNumber reverse:_numberResult];
    }

    if (_function == CCMultiply && _tmpOperand) {
        _numberResult = [NSDecimalNumber multiplyingByDecimalNumber:_tmpOperand rOperand:_numberResult];
        _function = CCNone;
        _tmpOperand = nil;
    } else if (_function == CCDivide && _tmpOperand) {
        _numberResult = [NSDecimalNumber dividingByDecimalNumber:_tmpOperand rOperand:_numberResult];
        _function = CCNone;
        _tmpOperand = nil;
    }

    return _numberResult;
}

////////////////////////////////////////////////////////////////////////////////
- (void)cacheWithNumber:(NSDecimalNumber *)rOperand
{
    if (!rOperand) {
        return;
    }
    [self setNumberResult:[NSDecimalNumber zero]];
}

////////////////////////////////////////////////////////////////////////////////
- (void)cacheWithDate:(NSDate *)rOperand
             function:(CCDateFunction)function
{
    if (!rOperand) {
        return;
    }

    if (!_numberResult || [_numberResult isEqualToNumber:[NSDecimalNumber zero]]) {
        [self setNumberResult:[NSDecimalNumber zero]];
        return;
    }

    _tmpOperand = _numberResult;
    _function = function;
    [self setDateRusult:rOperand];
}

////////////////////////////////////////////////////////////////////////////////
- (void)updateDateResult:(NSDate *)result
                function:(CCDateFunction)function
{
    [self setDateRusult:result];
    
    if (_numberResult) {
        if (function == CCPlus) {
            [self plusWithNumber:_numberResult];
        } else if (function == CCMinus) {
            [self minusWithNumber:_numberResult];
        } else {
            NSLog(@"FUNCTION: %d", function);
            abort();
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)excludeDayCountWithStartDate:(NSDate *)startDate
                                          endDate:(NSDate *)endDate
{
    if ([self.excludeWeeks count] == 0) {
        return [NSDecimalNumber zero];
    }
    
    NSDate *minDate, *maxDate;
    if ([startDate compare:endDate] == NSOrderedAscending) {
        minDate = [startDate addingByDay:1];
        maxDate = endDate;
    } else {
        minDate = [endDate addingByDay:1];
        maxDate = startDate;
    }

    NSInteger excludeDayCount = 0;
    NSInteger weekday = [minDate weekday];
    NSInteger interval = [minDate dayIntervalWithDate:maxDate];
    for (NSInteger day = 0; day <= interval; day++) {
        if (weekday > ASCSaturday) {
            weekday = ASCSunday;
        }
        if ([self.excludeWeeks containsObject:@(weekday)]) {
            excludeDayCount++;
        }
        weekday++;
    }
    
    return [NSDecimalNumber decimalNumberWithString:@(excludeDayCount).stringValue];
}

@end
