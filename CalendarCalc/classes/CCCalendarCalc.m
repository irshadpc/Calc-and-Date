//
//  CCCalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalc.h"
#import "CCCalendarCalcResult.h"
#import "CCCalendarCalcResult+Number.h"
#import "CCCalendarCalcResult+Date.h"
#import "CCNumberCalculator.h"
#import "CCDateCalculator.h"
#import "CCCalcType.h"

@interface CCCalendarCalc () {
  @private
    BOOL _isEqual;
}
- (CCCalendarCalcResult *)calculateWithFunction:(CCFunction)function;
- (CCCalendarCalcResult *)calculate;
- (void)numberCalculate;
- (void)dateCalculate;
- (void)datePlus;
- (void)dateMinus;
- (void)dateMultiply;
- (void)dateDivide;
- (CCCalendarCalcResult *)clearResult;
- (CCCalendarCalcResult *)reverseNumber;
- (CCCalendarCalcResult *)deleteNumber;
- (CCCalcType)calcType;
@end


@implementation CCCalendarCalc

- (id)init 
{
    if ((self = [super init])) {
        _numberCalculator = [[CCNumberCalculator alloc] init];
        _dateCalculator  = [[CCDateCalculator alloc] init];
        _result = [[CCCalendarCalcResult alloc] init];
    }
    return self;
}

- (CCCalendarCalcResult *)inputInteger:(NSInteger)integer
{
    return [self inputNumber:
            [NSDecimalNumber decimalNumberWithString:@(integer).stringValue]];
}

- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    if (_isEqual) {
        [_result endInput];
        [_numberCalculator clear];
        [_dateCalculator clear];
        _isEqual = NO;
    }
    return [_result inputNumber:number];
}

- (CCCalendarCalcResult *)inputDate:(NSDate *)date
{
    if (_isEqual) {
        [_result endInput];
        [_numberCalculator clear];
        [_dateCalculator clear];
        _isEqual = NO;
    }
    return [_result inputDate:date];
}

- (CCCalendarCalcResult *)inputFunction:(CCFunction)function
{
    switch (function) {
        case CCPlus:
        case CCMinus:
        case CCMultiply:
        case CCDivide:
            return [self calculateWithFunction:function];
        case CCEqual:
            _isEqual = YES;
            return [self calculate];
        case CCDecimal:
            return [_result inputDecimalPoint];
        case CCClear:
            return [self clearResult];
        case CCPlusMinus:
            return [self reverseNumber];
        case CCDelete:
            return [self deleteNumber];
        case CCFunctionMax:
        default:
            NSLog(@"FUNCTION: %d", function);
            abort();
    }
}

- (CCCalendarCalcResult *)result
{
    return _result;
}


#pragma mark - Private

- (CCCalendarCalcResult *)calculateWithFunction:(CCFunction)function
{
    [self calculate];

    _currentFunction = function;
    [_result endInput];
    return _result;
}

- (CCCalendarCalcResult *)calculate
{
    switch ([self calcType]) {
        case CCNumber:
            [self numberCalculate];
            break;
        case CCDate:
            [self dateCalculate];
            break;
        default:
            NSLog(@"CALC_TYPE: %d", [self calcType]);
            abort();
    }

    return _result;
}


- (void)numberCalculate
{
    switch (_currentFunction) {
        case CCPlus:
            [_numberCalculator plus:[_result numberResult]];
            break;
        case CCMinus:
            [_numberCalculator minus:[_result numberResult]];
            break;
        case CCMultiply:
            [_numberCalculator multiply:[_result numberResult]];
            break;
        case CCDivide:
            [_numberCalculator divide:[_result numberResult]];
            break;
        default:
            [_numberCalculator setResult:[_result numberResult]];
            [_dateCalculator setNumberResult:[_result numberResult]];
    }

    [_result setNumberResultForDisplay:[_numberCalculator result]];
}

- (void)dateCalculate
{
    switch (_currentFunction) {
        case CCPlus:
            [self datePlus];
            break;
        case CCMinus:
            [self dateMinus];
            break;
        case CCMultiply:
            [self dateMultiply];
            break;
        case CCDivide:
            [self dateDivide];
            break;
        default:
            [_dateCalculator setDateRusult:[_result dateResult]];
    }
    [_result setNumberResultForDisplay:[_dateCalculator numberResult]];
    [_result setDateResultForDisplay:[_dateCalculator dateResult]];
}

- (void)datePlus
{
    [_dateCalculator plusWithNumber:[_result numberResult]];
    [_dateCalculator plusWithDate:[_result dateResult]];
}

- (void)dateMinus
{
    [_dateCalculator minusWithNumber:[_result numberResult]];
    [_dateCalculator minusWithDate:[_result dateResult]];
}

- (void)dateMultiply
{
    [_dateCalculator multiplyWithNumber:[_result numberResult]];
    [_dateCalculator multiplyWithDate:[_result dateResult]];
}

- (void)dateDivide
{
    [_dateCalculator divideWithNumber:[_result numberResult]];
    [_dateCalculator divideWithDate:[_result dateResult]];
}

- (CCCalendarCalcResult *)clearResult
{
    if ([_result numberResult] || [_result dateResult]) {
        [_result clear];
    } else {
        [_result clear];
        [_numberCalculator clear];
        [_dateCalculator clear];
    }
    
    return _result;
}

- (CCCalendarCalcResult *)reverseNumber
{
    if (!_isEqual && [_result numberResult]) {
        [_result reverseNumberResult];
    } else if ([_numberCalculator result]) {
        [_result setNumberResult:[_numberCalculator reverse]];
    } else if ([_dateCalculator numberResult]) {
        [_result setNumberResult:[_dateCalculator reverse]];
    }
     
    if (_isEqual) {
        [_numberCalculator clear];
        [_dateCalculator clear];
        _isEqual = NO;
    }
    return _result;
}

- (CCCalendarCalcResult *)deleteNumber
{
    if (!_isEqual && ([_result numberResult] || [_result dateResult])) {
        [_result clearEntry];
    } else if ([_numberCalculator result]) {
        [_result setNumberResult:[_numberCalculator result]];
        [_result clearEntry];
    } else if ([_dateCalculator numberResult]) {
        [_result setNumberResult:[_dateCalculator numberResult]];
        [_result clearEntry];
    } 
    if (_isEqual) {
        [_numberCalculator clear];
        [_dateCalculator clear];
        _isEqual = NO;
    }
    
    return _result;
}

- (CCCalcType)calcType
{
    if ([_dateCalculator dateResult] || [_result dateResult]) {
        return CCDate;
    } else {
        return CCNumber;
    }
}

@end