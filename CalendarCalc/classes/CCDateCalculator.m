//
//  CCCalendarCalc+Date.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCDateCalculator.h"
#import "NSDate+Calc.h"
#import "NSDate+Component.h"
#import "NSDate+Style.h"
#import "NSDecimalNumber+Calc.h"
#import "NSDecimalNumber+Convert.h"
#import "NSNumber+Predicate.h"

#import "NSDateFormatter+CalendarCalc.h"

typedef enum {
    CCNone,
    CCMultiply,
    CCDivide,
} CCDateFunction;

@interface CCDateCalculator () {
  @private
    CCDateFunction _function;
    NSDecimalNumber *_tmpOperand;
}

- (NSDecimalNumber *)weekCountWithStartDate:(NSDate *)startDate
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
    if (!rOperand || !_dateResult) {
        return nil;
    }

    _isDateResult = YES;
    _dateResult = [_dateResult addingByDay:rOperand.integerValue];
    return _dateResult;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)plusWithDate:(NSDate *)rOperand 
{
    NSLog(@"L: %@", _dateResult);
    NSLog(@"R: %@", rOperand);
    if (!rOperand) {
        return nil;
    }

    if(!_dateResult && !_numberResult) {
        _isDateResult = YES;
        _dateResult = [rOperand noTime];
        return nil;
    } else if (!_dateResult) {
        _dateResult = [rOperand noTime];
        [self plusWithNumber:_numberResult];
        return nil;
    }

    _isDateResult = NO;
    _numberResult = [NSDecimalNumber decimalNumberWithString:
                     @([_dateResult dayIntervalWithDate: [rOperand noTime]]).stringValue];
    
    if ([_numberResult isMinus]) {
        _numberResult = [NSDecimalNumber reverse: _numberResult];
    }
   
    if (_function == CCMultiply && _tmpOperand) {
        _numberResult = [NSDecimalNumber multiplyingByDecimalNumber:_tmpOperand rOperand:_numberResult];
        _function = CCNone;
        _tmpOperand = nil;
        NSLog(@"MULTI: %@", _numberResult);
    } else if (_function == CCDivide && _tmpOperand) {
        _numberResult = [NSDecimalNumber dividingByDecimalNumber:_tmpOperand rOperand:_numberResult];
        _function = CCNone;
        _tmpOperand = nil;
    }
    
    /*_numberResult = [NSDecimalNumber subtractingByDecimalNumber: _numberResult
                                                       rOperand: [self weekCountWithStartDate: _dateResult
                                                                                      endDate: [rOperand noTime]]];

    if ([_numberResult isMinus]) {
        _numberResult = [NSDecimalNumber negate:_numberResult];
    }*/

    _dateResult = nil;
    return _numberResult;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)minusWithNumber:(NSDecimalNumber *)rOperand 
{
    if (!rOperand || !_dateResult) {
        return nil;
    }

    _isDateResult = YES;
    _dateResult = [_dateResult addingByDay:-rOperand.integerValue];
    return _dateResult;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)minusWithDate:(NSDate *)rOperand 
{
    if (!rOperand) {
        return nil;
    }

    if (!_dateResult && !_numberResult) {
        _isDateResult = YES;
        _dateResult = [rOperand noTime];
        return nil;
    } else if (!_dateResult) {
        _dateResult = [rOperand noTime];
        [self minusWithNumber:_numberResult];
        return nil;
    }

    _isDateResult = NO;
    _numberResult = [NSDecimalNumber decimalNumberWithString:
                     @([[rOperand noTime] dayIntervalWithDate: _dateResult]).stringValue];

    if (![_numberResult isMinus]) {
        _numberResult = [NSDecimalNumber reverse: _numberResult];
    }
    
    if (_function == CCMultiply && _tmpOperand) {
        _numberResult = [NSDecimalNumber multiplyingByDecimalNumber:_numberResult rOperand:_tmpOperand];
        _function = CCNone;
        _tmpOperand = nil;
    } else if (_function == CCDivide && _tmpOperand) {
        _numberResult = [NSDecimalNumber dividingByDecimalNumber:_numberResult rOperand:_tmpOperand];
        _function = CCNone;
        _tmpOperand = nil;
    }
    
    /*_numberResult = [NSDecimalNumber subtractingByDecimalNumber: _numberResult
                                                       rOperand: [self weekCountWithStartDate: _dateResult
                                                                                      endDate: [rOperand noTime]]];

    if ([_numberResult isMinus]) {
        _numberResult = [NSDecimalNumber negate:_numberResult];
    }*/

    _dateResult = nil;
    return _numberResult;
}

- (NSDate *)multiplyWithNumber:(NSDecimalNumber *)rOperand
{
    if (!rOperand) {
        return nil;
    }
    
    _isDateResult = NO;
    _numberResult = [NSDecimalNumber zero];
    return nil;
}

- (NSDecimalNumber *)multiplyWithDate:(NSDate *)rOperand
{
    if (!rOperand || !_numberResult) {
        return nil;
    }

    _tmpOperand = _numberResult;
    _function = CCMultiply;
    [self setDateRusult:rOperand];
    return nil;
}

- (NSDate *)divideWithNumber:(NSDecimalNumber *)rOperand
{
    if (!rOperand) {
        return nil;
    }

    _isDateResult = NO;
    _numberResult = [NSDecimalNumber zero];
    return nil;
}

- (NSDecimalNumber *)divideWithDate:(NSDate *)rOperand
{
    if (!rOperand || !_numberResult) {
        return nil;
    }

    _tmpOperand = _numberResult;
    _function = CCDivide;
    [self setDateRusult:rOperand];
    return nil;
}

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


- (NSDecimalNumber *)weekCountWithStartDate: (NSDate *)startDate
                                    endDate: (NSDate *)endDate
{
    NSDate *minDate, *maxDate;
    if ([startDate compare:endDate] <= 0) {
        minDate = [startDate addingByDay:1];
        maxDate = endDate;
    } else {
        minDate = [endDate addingByDay:1];
        maxDate = startDate;
    }

    NSMutableArray *disabledWeeks = [[NSMutableArray alloc] init];
    for (NSInteger weekStatIndex = 0; weekStatIndex < 7; weekStatIndex++) {
        if (![[self.weekStates objectAtIndex:weekStatIndex] boolValue]) {
            [disabledWeeks addObject: @(weekStatIndex + 1)];
        }
    }

    if ([disabledWeeks count] == 0) {
        disabledWeeks = nil;
        return [NSDecimalNumber zero];
    }

    NSInteger weekCount = 0;
    NSInteger weekday = [minDate weekday];
    NSInteger interval = [minDate dayIntervalWithDate:maxDate];
    for (NSInteger day = 0; day <= interval; day++) {
        if (weekday > 7) {
            weekday = 1;
        }
        if ([disabledWeeks indexOfObject: @(weekday)] != NSNotFound) {
            weekCount++;
        }
        weekday++;
    }
    disabledWeeks = nil;
    
    return [NSDecimalNumber decimalNumberWithString: @(weekCount).stringValue];
}

@end
