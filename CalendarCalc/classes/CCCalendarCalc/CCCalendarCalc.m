//
//  CCCalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalc.h"
#import "CCCalendarCalc+Function.h"
#import "CCCalendarCalcResult.h"
#import "CCCalendarCalcResult+Number.h"
#import "CCCalendarCalcResult+Date.h"
#import "CCNumberCalculator.h"
#import "CCDateCalculator.h"
#import "NSDecimalNumber+Convert.h"
#import "NSString+Locale.h"
#import "CCCalcType.h"

@interface CCCalendarCalc ()
@property (nonatomic, readwrite) CCFunction lastFunction;

- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number;
- (CCCalendarCalcResult *)inputNumberString:(NSString *)numberString;
- (CCCalendarCalcResult *)inputDateString:(NSString *)dateString;
- (CCCalendarCalcResult *)inputDecimalPoint;
- (CCCalendarCalcResult *)calculateWithFunction:(CCFunction)function;
- (CCCalendarCalcResult *)calculate;
- (void)numberCalculate;
- (void)dateCalculate;
- (void)datePlus;
- (void)dateMinus;
- (void)dateMultiply;
- (void)dateDivide;
- (void)endInput;
- (CCCalcType)calcType;
@end


@implementation CCCalendarCalc

- (id)init 
{
    if ((self = [super init])) {
        _numberCalculator = [[CCNumberCalculator alloc] init];
        _dateCalculator  = [[CCDateCalculator alloc] init];
        _result = [[CCCalendarCalcResult alloc] init];
        _currentFunction = CCFunctionNone;
        _lastFunction = CCFunctionNone;
    }
    return self;
}

- (CCCalendarCalcResult *)inputInteger:(NSInteger)integer
{
    return [self inputNumber:
            [NSDecimalNumber decimalNumberWithString:@(integer).stringValue]];
}

- (CCCalendarCalcResult *)inputDate:(NSDate *)date
{
    if (_isEqual) {
        [self endInput];
        _isEqual = NO;
    }
    return [_result inputDate:date];
}

- (CCCalendarCalcResult *)inputString:(NSString *)string
{
    if ([CCCalendarCalcResult numberFromString:string]) {
        return [self inputNumberString:string];
    } else if ([CCCalendarCalcResult dateFromString:string]) {
        return [self inputDateString:string];
    } else {
        return _result;
    }
}

- (CCCalendarCalcResult *)inputFunction:(CCFunction)function
{
    self.lastFunction = function;
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
            return [self inputDecimalPoint];
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

- (void)setWeek:(ASCWeek)week
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
            (_isEqual || _currentFunction == CCFunctionNone);
}


#pragma mark - Private

- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    if (_isEqual) {
        [self endInput];
        _isEqual = NO;
    }
    return [_result inputNumber:number];
}

- (CCCalendarCalcResult *)inputNumberString:(NSString *)numberString
{
    NSArray *numberComponents = [numberString componentsSeparatedByString:[NSString decimalSeparator]];
    if (numberComponents.count == 1) {
        [self inputNumber:[CCCalendarCalcResult numberFromString:numberComponents[0]]];
    } else if (numberComponents.count == 2) {
        [self inputNumber:[CCCalendarCalcResult numberFromString:numberComponents[0]]];
        [self inputFunction:CCDecimal];
        [self inputNumber:[CCCalendarCalcResult numberFromString:numberComponents[1]]];
    }
    return _result;
}

- (CCCalendarCalcResult *)inputDateString:(NSString *)dateString
{
    return [self inputDate:[CCCalendarCalcResult dateFromString:dateString]];
}

- (CCCalendarCalcResult *)inputDecimalPoint
{
    if (_isEqual) {
        [self endInput];
        _isEqual = NO;
    }
    return [_result inputDecimalPoint];
}

- (CCCalendarCalcResult *)calculateWithFunction:(CCFunction)function
{
    if (!_isEqual) {        
        [self calculate];
    } else {
        _isEqual = NO;
    }

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
    if (_isEqual && ![_result numberResult]) {
        [_result setNumberResult:[_numberCalculator result]];
    }
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
    [_dateCalculator setNumberResult:[_numberCalculator result]];
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
        _currentFunction = CCPlus;
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

- (CCCalcType)calcType
{
    if ([_dateCalculator dateResult] || [_result dateResult]) {
        return CCDate;
    } else {
        return CCNumber;
    }
}

@end