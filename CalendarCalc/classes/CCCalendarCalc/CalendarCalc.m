//
//  CCCalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalc.h"
#import "CalendarCalc+Function.h"
#import "CalendarCalcResult.h"
#import "CalendarCalcResult+Number.h"
#import "CalendarCalcResult+Date.h"
#import "NumberCalculator.h"
#import "DateCalculator.h"
#import "NSDecimalNumber+Convert.h"
#import "NSString+Locale.h"
#import "CalcType.h"

@interface CalendarCalc ()
@property (nonatomic, readwrite) Function lastFunction;

- (CalendarCalcResult *)inputNumber:(NSDecimalNumber *)number;
- (CalendarCalcResult *)inputNumberString:(NSString *)numberString;
- (CalendarCalcResult *)inputDateString:(NSString *)dateString;
- (CalendarCalcResult *)inputDecimalPoint;
- (CalendarCalcResult *)calculateWithFunction:(Function)function;
- (CalendarCalcResult *)calculate;
- (void)numberCalculate;
- (void)dateCalculate;
- (void)datePlus;
- (void)dateMinus;
- (void)dateMultiply;
- (void)dateDivide;
- (void)endInput;
- (CalcType)calcType;
@end


@implementation CalendarCalc

- (id)init 
{
    if ((self = [super init])) {
        _numberCalculator = [[NumberCalculator alloc] init];
        _dateCalculator  = [[DateCalculator alloc] init];
        _result = [[CalendarCalcResult alloc] init];
        _currentFunction = FunctionNone;
        _lastFunction = FunctionNone;
    }
    return self;
}

- (CalendarCalcResult *)inputInteger:(NSInteger)integer
{
    return [self inputNumber:
            [NSDecimalNumber decimalNumberWithString:@(integer).stringValue]];
}

- (CalendarCalcResult *)inputDate:(NSDate *)date
{
    if (_isEqual) {
        [self endInput];
        _isEqual = NO;
    }
    return [_result inputDate:date];
}

- (CalendarCalcResult *)inputString:(NSString *)string
{
    if ([CalendarCalcResult numberFromString:string]) {
        return [self inputNumberString:string];
    } else if ([CalendarCalcResult dateFromString:string]) {
        return [self inputDateString:string];
    } else {
        return _result;
    }
}

- (CalendarCalcResult *)inputFunction:(Function)function
{
    self.lastFunction = function;
    switch (function) {
        case FunctionPlus:
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionDivide:
            return [self calculateWithFunction:function];
        case FunctionEqual:
            _isEqual = YES;
            return [self calculate];
        case FunctionDecimal:
            return [self inputDecimalPoint];
        case FunctionClear:
            return [self clearResult];
        case FunctionPlusMinus:
            return [self reverseNumber];
        case FunctionDelete:
            return [self deleteNumber];
        case FunctionMax:
        default:
            NSLog(@"FUNCTION: %d", function);
            abort();
    }
}

- (CalendarCalcResult *)result
{
    return _result;
}

- (void)setWeek:(Week)week
        exclude:(BOOL)exclude
{
    NSMutableArray *excludeWeeks = [NSMutableArray arrayWithArray:[_dateCalculator excludeWeeks]];
    [excludeWeeks removeObject:@(week)];
    if (exclude) {
        [excludeWeeks addObject:@(week)];
    }
    [_dateCalculator setExcludeWeeks:excludeWeeks];
}

- (BOOL)isAllCleared
{
    return ![_result numberResult] && 
            ![_result dateResult] &&
            (_isEqual || _currentFunction == FunctionNone);
}


#pragma mark - Private

- (CalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    if (_isEqual) {
        [self endInput];
        _isEqual = NO;
    }
    return [_result inputNumber:number];
}

- (CalendarCalcResult *)inputNumberString:(NSString *)numberString
{
    NSArray *numberComponents = [numberString componentsSeparatedByString:[NSString decimalSeparator]];
    if (numberComponents.count == 1) {
        [self inputNumber:[CalendarCalcResult numberFromString:numberComponents[0]]];
    } else if (numberComponents.count == 2) {
        [self inputNumber:[CalendarCalcResult numberFromString:numberComponents[0]]];
        [self inputFunction:FunctionDecimal];
        [self inputNumber:[CalendarCalcResult numberFromString:numberComponents[1]]];
    }
    return _result;
}

- (CalendarCalcResult *)inputDateString:(NSString *)dateString
{
    return [self inputDate:[CalendarCalcResult dateFromString:dateString]];
}

- (CalendarCalcResult *)inputDecimalPoint
{
    if (_isEqual) {
        [self endInput];
        _isEqual = NO;
    }
    return [_result inputDecimalPoint];
}

- (CalendarCalcResult *)calculateWithFunction:(Function)function
{
    if (!_isEqual) {        
        [self calculate];
    } else {
        [_result setNumberResultForDisplay:[_numberCalculator result]];
        [_result setDateResultForDisplay:[_dateCalculator dateResult]];
        _isEqual = NO;
    }

    _currentFunction = function;
    [_result endInput];
    return _result;
}

- (CalendarCalcResult *)calculate
{
    switch ([self calcType]) {
        case CalcTypeNumber:
            [self numberCalculate];
            break;
        case CalcTypeDate:
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
    if (_isEqual && ![_result numberResult]) {
        [_result setNumberResult:[_numberCalculator result]];
    }
    switch (_currentFunction) {
        case FunctionPlus:
            [_numberCalculator plus:[_result numberResult]];
            break;
        case FunctionMinus:
            [_numberCalculator minus:[_result numberResult]];
            break;
        case FunctionMultiply:
            [_numberCalculator multiply:[_result numberResult]];
            break;
        case FunctionDivide:
            [_numberCalculator divide:[_result numberResult]];
            break;
        default:
            [_numberCalculator setResult:[_result numberResult]];
            [_dateCalculator setNumberResult:[_result numberResult]];
    }
    [_dateCalculator setNumberResult:[_numberCalculator result]];
    [_result setNumberResultForDisplay:[_numberCalculator result]];
}

- (void)dateCalculate
{
    switch (_currentFunction) {
        case FunctionPlus:
            [self datePlus];
            break;
        case FunctionMinus:
            [self dateMinus];
            break;
        case FunctionMultiply:
            [self dateMultiply];
            break;
        case FunctionDivide:
            [self dateDivide];
            break;
        default:
            [_dateCalculator setDateRusult:[_result dateResult]];
    }
    [_numberCalculator setResult:[_dateCalculator numberResult]];
    [_result setNumberResultForDisplay:[_dateCalculator numberResult]];
    [_result setDateResultForDisplay:[_dateCalculator dateResult]];
    if ([_result dateResult]) {
        [_result endInput];
    }
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
    if ([_dateCalculator numberResult]) {
        _currentFunction = FunctionPlus;
    }
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

- (void)endInput
{
    [_result endInput];
    [_numberCalculator clear];
    [_dateCalculator clear];
}

- (CalcType)calcType
{
    if ([_dateCalculator dateResult] || [_result dateResult]) {
        return CalcTypeDate;
    } else {
        return CalcTypeNumber;
    }
}

@end