//
//  CalcController.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/14.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcController.h"
#import "NumberCalcProcessor.h"
#import "DateCalcProcessor.h"
#import "CalcValue.h"
#import "NSArray+safe.h"
#import "NSDateFormatter+CalendarCalc.h"
#import "NSString+Calculator.h"
#import "NSString+Locale.h"

typedef enum {
   ModeInput,
   ModeFunction,
   ModeEqual,
} Mode;

@interface CalcController ()
@property(strong, nonatomic) NumberCalcProcessor *numberCalcProcessor;
@property(strong, nonatomic) DateCalcProcessor *dateCalcProcessor;
@property(strong, nonatomic) CalcValue *resultValue;
@property(strong, nonatomic) CalcValue *inputValue;
@property(strong, nonatomic) NSDecimalNumber *cachedNumberInput;
@property(nonatomic) Function cachedFunction;
@property(nonatomic) Mode currentMode;

- (CalcValue *)inputKeyCode:(NSInteger)keycode;
- (CalcValue *)inputFunction:(Function)function;
- (CalcValue *)inputNumberString:(NSString *)numberString;
- (CalcValue *)inputDecimalPoint;
- (CalcValue *)clear;
- (CalcValue *)reverseNumber;
- (CalcValue *)deleteNumber;
- (CalcValue *)calculateWithFunction:(Function)function;
- (CalcValue *)numberCalculate;
- (CalcValue *)dateCalculate;
- (CalcValue *)dateCalculateCacheWithFunction:(Function)function;
- (Mode)modeWithFunction:(Function)function;
- (void)willInputMode;
- (void)reset;
@end

@implementation CalcController
static const NSInteger KeyCodeDoubleZero = 10;

- (instancetype)init
{
    if ((self = [super init])) {
        _numberCalcProcessor = [[NumberCalcProcessor alloc] init];
        _dateCalcProcessor = [[DateCalcProcessor alloc] init];
        _inputValue = [[CalcValue alloc] init];
    }
    return self;
}

- (CalcValue *)inputInteger:(NSInteger)integer
{
    if (integer < FunctionDecimal) {
        return [self inputKeyCode:integer];
    } else {
        return [self inputFunction:integer];
    }
}

- (CalcValue *)inputDate:(NSDate *)date
{
    [self willInputMode];
    self.currentMode = ModeInput;

    [self.inputValue inputDate:date];
    return self.inputValue;
}

- (CalcValue *)setStringValue:(NSString *)stringValue
{
    [self.inputValue clear];

    NSDate *date = [[NSDateFormatter yyyymmddFormatter] dateFromString:stringValue];
    if (date) {
        return [self inputDate:date];
    } else {
        return [self inputNumberString:stringValue];
    }
}

- (void)setIncludeStartDay:(BOOL)includeStartDay
{
    _includeStartDay = includeStartDay;
    [self.dateCalcProcessor setIncludeStartDay:includeStartDay];
}

- (void)setWeek:(Week)week exclude:(BOOL)exclude
{
    NSMutableArray *excludeWeeks = [NSMutableArray arrayWithArray:[self.dateCalcProcessor excludeWeeks]];
    [excludeWeeks removeObject:@(week)];
    if (exclude) {
        [excludeWeeks addObject:@(week)];
    }
    [self.dateCalcProcessor setExcludeWeeks:excludeWeeks];
}

- (BOOL)isAllCleared
{
    return (!self.inputValue || [self.inputValue isCleared])
            && (!self.resultValue || [self.resultValue isCleared]);
}


#pragma mark - Private

- (CalcValue *)inputKeyCode:(NSInteger)keycode
{
    [self willInputMode];
    self.currentMode = ModeInput;
    
    if (keycode == KeyCodeDoubleZero) {
        [self.inputValue inputNumberString:@"00"];
    } else {
        [self.inputValue inputNumberString:[@(keycode) stringValue]];
    }
    return self.inputValue;
}

- (CalcValue *)inputFunction:(Function)function
{
    switch (function) {
        case FunctionNone:
        case FunctionPlus:
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionDivide:
        case FunctionEqual:
            return [self calculateWithFunction:function];
        case FunctionDecimal:
            return [self inputDecimalPoint];
        case FunctionClear:
            return [self clear];
        case FunctionPlusMinus:
            return [self reverseNumber];
        case FunctionDelete:
            return [self deleteNumber];
        case FunctionMax:
            NSLog(@"FUNCTION: %d", function);
            abort();
    }
}

- (CalcValue *)inputNumberString:(NSString *)numberString
{
    [self willInputMode];
    self.currentMode = ModeInput;

    NSArray *components = [numberString componentsSeparatedByString:[NSString decimalSeparator]];
    NSString *number = [components safeObjectAtIndex:0];
    if (number) {
        [self.inputValue inputNumberString:[number stringByReplacingOccurrencesOfString:[NSString groupingSeparator]
                                                                             withString:@""]];
    }
    NSString *decimal = [components safeObjectAtIndex:1];
    if (decimal) {
        [self.inputValue inputDecimalPoint];
        [self.inputValue inputNumberString:[decimal stringByReplacingOccurrencesOfString:[NSString groupingSeparator]
                                                                              withString:@""]];
    }
    return self.inputValue;
}

- (CalcValue *)clear
{
    if (self.currentMode == ModeEqual) {
        [self reset];
        return self.inputValue;
    }
    
    if (![self.inputValue isCleared]) {
        [self.inputValue clear];
        return self.inputValue;
    } else {
        [self reset];
        return self.inputValue;
    }
}

- (CalcValue *)inputDecimalPoint
{
    [self willInputMode];
    self.currentMode = ModeInput;
    [self.inputValue inputDecimalPoint];
    return self.inputValue;
}

- (CalcValue *)reverseNumber
{
    if (self.currentMode == ModeEqual) {
        CalcValue *resultValue = self.resultValue;
        [self reset];
        self.inputValue = resultValue;
        [self.inputValue reverseNumber];
        return self.inputValue;
    }
    [self.inputValue reverseNumber];
    return self.inputValue;
}

- (CalcValue *)deleteNumber
{
    if (self.currentMode == ModeEqual) {
        self.inputValue = [[CalcValue alloc] init];
        return self.inputValue;
    }

    [self.inputValue deleteNumber];
    return self.inputValue;
}

- (CalcValue *)calculateWithFunction:(Function)function
{
    if ((self.currentMode != ModeInput && function != FunctionEqual) || (self.currentFunction == FunctionEqual)) {
        self.currentFunction = function;
        self.currentMode = [self modeWithFunction:function];
        return self.resultValue;
    }
    
    if (!self.resultValue || self.currentFunction == FunctionEqual) {
        self.resultValue = self.inputValue;
        self.inputValue = [[CalcValue alloc] init];
        self.currentMode = [self modeWithFunction:function];
        self.currentFunction = function;
        return self.resultValue;
    }

    if ([self.resultValue isNumber] && [self.inputValue isNumber]) {
        self.resultValue = [self numberCalculate];
    } else {
        self.resultValue = [self dateCalculate];
    }
    
    self.currentMode = [self modeWithFunction:function];
    if (self.currentMode == ModeFunction) {
        self.currentFunction = function;
        self.inputValue = [[CalcValue alloc] init];
    } 

    return self.resultValue;
}

- (CalcValue *)numberCalculate
{
    if ([self.inputValue isCleared]) {
        self.inputValue = [CalcValue calcValueWithDecimalNumber:[self.resultValue decimalNumberValue]];
    } 
    NSDecimalNumber *result = [self.numberCalcProcessor calculateWithFunction:self.currentFunction
                                                                     lOperand:[self.resultValue decimalNumberValue] 
                                                                     rOperand:[self.inputValue decimalNumberValue]];
    return [CalcValue calcValueWithDecimalNumber:result];
}

- (CalcValue *)dateCalculate
{
    if (self.currentMode == ModeEqual && [self.resultValue isNumber]) {
        self.currentFunction = FunctionPlus;
        [self.inputValue clear];
        return [self numberCalculate];
    }
    
    if (self.currentFunction == FunctionMultiply || self.currentFunction == FunctionDivide) {
        return [self dateCalculateCacheWithFunction:self.currentFunction];
    }
    
    CalcValue *result = [self.dateCalcProcessor calculateWithFunction:self.currentFunction
                                                             lOperand:self.resultValue
                                                             rOperand:self.inputValue];
    if ([result isNumber] && self.cachedNumberInput) {
        NSDecimalNumber *numberResult = [self.numberCalcProcessor calculateWithFunction:self.cachedFunction
                                                                               lOperand:self.cachedNumberInput
                                                                               rOperand:[result decimalNumberValue]];
        self.cachedNumberInput = nil;
        self.cachedFunction = FunctionNone;
        return [CalcValue calcValueWithDecimalNumber:numberResult];
    } else {
        return result;
    }
}

- (CalcValue *)dateCalculateCacheWithFunction:(Function)function
{
    if (![self.resultValue isNumber] || [[self.resultValue decimalNumberValue] isEqualToNumber:@0]) {
        self.resultValue = nil;
        self.inputValue = [[CalcValue alloc] init];
        return self.inputValue;
    }
    
    self.cachedNumberInput = [self.resultValue decimalNumberValue];
    self.cachedFunction = function;
    return self.inputValue;   
}

- (Mode)modeWithFunction:(Function)function
{
    return function == FunctionEqual ? ModeEqual : ModeFunction;
}

- (void)willInputMode
{
    if (self.currentMode == ModeEqual) {
        [self reset];
    } else if (self.currentMode == ModeFunction) {
        self.inputValue = [[CalcValue alloc] init];
    }
}

- (void)reset
{
    self.currentFunction = FunctionNone;
    self.resultValue = nil;
    self.inputValue = [[CalcValue alloc] init];
    self.cachedNumberInput = nil;
    self.currentMode = ModeInput;
}
@end
