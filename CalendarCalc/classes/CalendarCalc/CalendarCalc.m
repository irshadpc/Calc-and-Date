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
@property(nonatomic, readwrite) Function lastFunction;

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
            [NSDecimalNumber decimalNumberWithString:[@(integer) stringValue]]];
}

- (CalendarCalcResult *)inputDate:(NSDate *)date
{
    if (self.isEqual) {
        [self endInput];
        self.equal = NO;
    }
    return [self.result inputDate:date];
}

- (CalendarCalcResult *)inputString:(NSString *)string
{
    if ([CalendarCalcResult numberFromString:string]) {
        return [self inputNumberString:string];
    } else if ([CalendarCalcResult dateFromString:string]) {
        return [self inputDateString:string];
    } else {
        return self.result;
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
            self.equal = YES;
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

- (void)setWeek:(Week)week
        exclude:(BOOL)exclude
{
    NSMutableArray *excludeWeeks = [NSMutableArray arrayWithArray:[self.dateCalculator excludeWeeks]];
    [excludeWeeks removeObject:@(week)];
    if (exclude) {
        [excludeWeeks addObject:@(week)];
    }
    [self.dateCalculator setExcludeWeeks:excludeWeeks];
}

- (BOOL)isAllCleared
{
    return ![self.result numberResult] &&
            ![self.result dateResult] &&
            (self.isEqual || self.currentFunction == FunctionNone);
}


#pragma mark - Private

- (CalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    if (self.isEqual) {
        [self endInput];
        self.equal = NO;
    }
    return [self.result inputNumber:number];
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
    return self.result;
}

- (CalendarCalcResult *)inputDateString:(NSString *)dateString
{
    return [self inputDate:[CalendarCalcResult dateFromString:dateString]];
}

- (CalendarCalcResult *)inputDecimalPoint
{
    if (self.isEqual) {
        [self endInput];
        self.equal = NO;
    }
    return [self.result inputDecimalPoint];
}

- (CalendarCalcResult *)calculateWithFunction:(Function)function
{
    if (!self.isEqual) {
        [self calculate];
    } else {
        [self.result setNumberResultForDisplay:[self.numberCalculator result]];
        [self.result setDateResultForDisplay:[self.dateCalculator dateResult]];
        self.equal = NO;
    }

    self.currentFunction = function;
    [self.result endInput];
    return self.result;
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

    return self.result;
}

- (void)numberCalculate
{
    if (self.isEqual && ![self.result numberResult]) {
        [self.result setNumberResult:[self.numberCalculator result]];
    }
    switch (self.currentFunction) {
        case FunctionPlus:
            [self.numberCalculator plus:[self.result numberResult]];
            break;
        case FunctionMinus:
            [self.numberCalculator minus:[self.result numberResult]];
            break;
        case FunctionMultiply:
            [self.numberCalculator multiply:[self.result numberResult]];
            break;
        case FunctionDivide:
            [self.numberCalculator divide:[self.result numberResult]];
            break;
        default:
            [self.numberCalculator setResult:[self.result numberResult]];
            [self.dateCalculator setNumberResult:[self.result numberResult]];
    }
    [self.dateCalculator setNumberResult:[self.numberCalculator result]];
    [self.result setNumberResultForDisplay:[self.numberCalculator result]];
}

- (void)dateCalculate
{
    switch (self.currentFunction) {
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
            [self.dateCalculator setDateRusult:[self.result dateResult]];
    }
    [self.numberCalculator setResult:[self.dateCalculator numberResult]];
    [self.result setNumberResultForDisplay:[self.dateCalculator numberResult]];
    [self.result setDateResultForDisplay:[self.dateCalculator dateResult]];
    if ([self.result dateResult]) {
        [self.result endInput];
    }
}

- (void)datePlus
{
    [self.dateCalculator plusWithNumber:[self.result numberResult]];
    [self.dateCalculator plusWithDate:[self.result dateResult]];
}

- (void)dateMinus
{
    [self.dateCalculator minusWithNumber:[self.result numberResult]];
    [self.dateCalculator minusWithDate:[self.result dateResult]];
    if ([self.dateCalculator numberResult]) {
        self.currentFunction = FunctionPlus;
    }
}

- (void)dateMultiply
{
    [self.dateCalculator multiplyWithNumber:[self.result numberResult]];
    [self.dateCalculator multiplyWithDate:[self.result dateResult]];
}

- (void)dateDivide
{
    [self.dateCalculator divideWithNumber:[self.result numberResult]];
    [self.dateCalculator divideWithDate:[self.result dateResult]];
}

- (void)endInput
{
    [self.result endInput];
    [self.numberCalculator clear];
    [self.dateCalculator clear];
}

- (CalcType)calcType
{
    if ([self.dateCalculator dateResult] || [self.result dateResult]) {
        return CalcTypeDate;
    } else {
        return CalcTypeNumber;
    }
}
@end