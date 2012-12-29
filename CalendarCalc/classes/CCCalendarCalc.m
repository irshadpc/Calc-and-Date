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

@interface CCCalendarCalc ()
- (CCCalendarCalcResult *)calculateWithFunction:(CCFunction)function;
- (void)numberCalculate;
- (void)dateCalculate;
- (void)datePlus;
- (void)dateMinus;
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
    return [_result inputNumber:number];
}

- (CCCalendarCalcResult *)inputDate:(NSDate *)date
{
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
            return [self calculateWithFunction:_currentFunction];
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

    _currentFunction = function;
    [_result clear];
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
    [_result setNumberResult:[_numberCalculator result]];
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
            break;
        case CCDivide:
            break;
        default:
            [_dateCalculator setDateRusult:[_result dateResult]];
    }
    [_result setNumberResult:[_dateCalculator numberResult]];
    [_result setDateResult:[_dateCalculator dateResult]];
}

- (void)datePlus
{
    if ([_result numberResult]) {
        [_dateCalculator plusWithNumber:[_result numberResult]];
    } else if ([_result dateResult]) {
        [_dateCalculator plusWithDate:[_result dateResult]];
    }
}

- (void)dateMinus
{
    if ([_result numberResult]) {
        [_dateCalculator minusWithNumber:[_result numberResult]];
    } else if ([_result dateResult]) {
        [_dateCalculator minusWithDate:[_result dateResult]];
    } else {
        abort();
    }
}

- (CCCalendarCalcResult *)clearResult
{
    if ([_result numberResult] || [_result dateResult]) {
        [_result allClear];
    } else {
        [_result allClear];
        [_numberCalculator clear];
        [_dateCalculator clear];
    }
    
    return _result;
}

- (CCCalendarCalcResult *)reverseNumber
{
    if ([_numberCalculator result]) {
        [_result setNumberResult:[_numberCalculator reverse]];
    } else if ([_dateCalculator numberResult]) {
        [_result setNumberResult:[_dateCalculator reverse]];
    } else {
        [_result reverseNumberResult];
    } 
    return _result;
}

- (CCCalendarCalcResult *)deleteNumber
{
    [_result clearEntry];
    
    if ([_numberCalculator result]) {
        [_numberCalculator setResult:[_result numberResult]];
    } else if ([_dateCalculator numberResult]) {
        [_dateCalculator setNumberResult:[_result numberResult]];
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