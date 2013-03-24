//
//  CCCalendarCalc+Date.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "DateCalculator.h"
#import "AppDelegate+Setting.h"
#import "NSDate+Calc.h"
#import "NSDate+Component.h"
#import "NSDate+Style.h"
#import "NSDecimalNumber+Calc.h"
#import "NSDecimalNumber+Convert.h"
#import "NSNumber+Predicate.h"
#import "Week.h"

typedef enum {
    DateFunctionNone,
    DateFunctionPlus,
    DateFunctionMinus,
    DateFunctionMultiply,
    DateFunctionDivide,
} DateFunction;

@interface DateCalculator () {
  @private
    DateFunction _function;
    NSDecimalNumber *_tmpOperand;
}
- (NSDate *)calcWithNumber:(NSDecimalNumber *)rOperand function:(DateFunction)function;
- (NSDecimalNumber *)calcWithDate:(NSDate *)rOperand function:(DateFunction)function;
- (void)cacheWithNumber:(NSDecimalNumber *)rOperand;
- (void)cacheWithDate:(NSDate *)rOperand function:(DateFunction)function;
- (void)updateDateResult:(NSDate *)result function:(DateFunction)function;
- (NSDecimalNumber *)excludeDayCountWithStartDate:(NSDate *)startDate
                                          endDate:(NSDate *)endDate;
@end


@implementation DateCalculator

////////////////////////////////////////////////////////////////////////////////
- (void)clear
{
    _numberResult = nil;
    _dateResult = nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)plusWithNumber:(NSDecimalNumber *)rOperand 
{
    return [self calcWithNumber:rOperand function:DateFunctionPlus];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)plusWithDate:(NSDate *)rOperand 
{
    return [self calcWithDate:rOperand function:DateFunctionPlus];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)minusWithNumber:(NSDecimalNumber *)rOperand 
{
    return [self calcWithNumber:rOperand function:DateFunctionMinus];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)minusWithDate:(NSDate *)rOperand 
{
    return [self calcWithDate:rOperand function:DateFunctionMinus];
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
    [self cacheWithDate:rOperand function:DateFunctionMultiply];
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
    [self cacheWithDate:rOperand function:DateFunctionDivide];
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
                  function:(DateFunction)function
{
    if (!rOperand || !_dateResult) {
        return nil;
    }

    NSInteger addingDay = 0;
    switch (function) {
        case DateFunctionPlus:
            addingDay = rOperand.integerValue;
            break;
        case DateFunctionMinus:
            addingDay = -rOperand.integerValue;
            break;
        case DateFunctionMultiply:
        case DateFunctionDivide:
        default:
            NSLog(@"FUNCTION: %d", function);
            abort();
    }

    _numberResult = nil;
    return [self setDateRusult:[_dateResult addingByDay:addingDay]];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)calcWithDate:(NSDate *)rOperand 
                         function:(DateFunction)function
{
    if (!rOperand) {
        return nil;
    }

    if (!_dateResult) {
        [self updateDateResult:rOperand function:function];
        return nil;
    }

    NSDate *lOperand = nil;
     if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] includeStartDayOption]) {
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

    if ((function == DateFunctionPlus && [_numberResult isMinus]) || (function == DateFunctionMinus && ![_numberResult isMinus])) {
        _numberResult = [NSDecimalNumber reverse:_numberResult];
    }

    if (_function == DateFunctionMultiply && _tmpOperand) {
        _numberResult = [NSDecimalNumber multiplyingByDecimalNumber:_tmpOperand rOperand:_numberResult];
        _function = DateFunctionNone;
        _tmpOperand = nil;
    } else if (_function == DateFunctionDivide && _tmpOperand) {
        _numberResult = [NSDecimalNumber dividingByDecimalNumber:_tmpOperand rOperand:_numberResult];
        _function = DateFunctionNone;
        _tmpOperand = nil;
    }

    _dateResult = nil;
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
             function:(DateFunction)function
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
                function:(DateFunction)function
{
    [self setDateRusult:result];
    
    if (_numberResult) {
        if (function == DateFunctionPlus) {
            [self plusWithNumber:_numberResult];
        } else if (function == DateFunctionMinus) {
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
        if (weekday > Saturday) {
            weekday = Sunday;
        }
        if ([self.excludeWeeks containsObject:@(weekday)]) {
            excludeDayCount++;
        }
        weekday++;
    }
    
    return [NSDecimalNumber decimalNumberWithString:@(excludeDayCount).stringValue];
}

@end
