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
#import "NSNumber+Predicate.h"
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
@property(nonatomic) Function functionForDisplay;
@property(nonatomic) Function functionForCalc;
@property(nonatomic) Function functionForPendingCalc;
@property(strong, nonatomic) CalcValue *resultValue;
@property(strong, nonatomic) CalcValue *inputValue;
@property(strong, nonatomic) CalcValue *lastValue;
@property(strong, nonatomic) NSDecimalNumber *numberInputForPendingCalc;
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
- (CalcValue *)pendingDateCalculateWithFunction:(Function)function;
- (Mode)modeWithFunction:(Function)function;
- (void)willInputMode;
- (void)reset;
- (void)clearPendingCalc;
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

- (CalcController *)inputInteger:(NSInteger)integer
{
    if (integer < FunctionDecimal) {
        self.lastValue = [self inputKeyCode:integer];
    } else {
        self.lastValue = [self inputFunction:integer];
    }
    return self;
}

- (CalcController *)inputDate:(NSDate *)date
{
    [self willInputMode];
    self.currentMode = ModeInput;

    [self.inputValue inputDate:date];
    self.lastValue = self.inputValue;

    return self;
}

- (CalcController *)setStringValue:(NSString *)stringValue
{
    [self.inputValue clear];

    NSDate *date = [[NSDateFormatter yyyymmddFormatter] dateFromString:stringValue];
    if (date) {
        return [self inputDate:date];
    }
    
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:stringValue
                                                                       locale:[NSLocale currentLocale]];
    if ([decimalNumber isNan]) {
        self.lastValue = [self inputNumberString:@"0"];
    } else {
        self.lastValue = [self inputNumberString:stringValue];
    }
    return self;
}

- (Function)function
{
    return self.functionForDisplay;
}

- (CalcValue *)result
{
    return self.lastValue;
}

- (CalcValue *)operand
{
    return self.resultValue;
}

- (Function)pendingFunction
{
    return self.functionForPendingCalc;
}

- (CalcValue *)pendingValue
{
    if (!self.numberInputForPendingCalc) {
        return nil;
    } 
    return [CalcValue calcValueWithDecimalNumber:self.numberInputForPendingCalc];
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
            self.functionForDisplay = function;
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
    if ((self.currentMode != ModeInput && function != FunctionEqual) || (self.functionForCalc == FunctionEqual)) {
        self.functionForCalc = function;
        self.currentMode = [self modeWithFunction:function];
        return self.resultValue;
    }
    
    if (!self.resultValue || self.functionForCalc == FunctionEqual) {
        self.resultValue = self.inputValue;
        self.inputValue = [[CalcValue alloc] init];
        self.currentMode = [self modeWithFunction:function];
        self.functionForCalc = function;
        return self.resultValue;
    }

    if ([self.resultValue isNumber] && [self.inputValue isNumber]) {
        self.resultValue = [self numberCalculate];
        [self clearPendingCalc];
    } else {
        BOOL isPendingCalc = self.functionForCalc == FunctionMultiply || self.functionForCalc == FunctionDivide;
       if (!isPendingCalc) {
           self.resultValue = [self dateCalculate];
       } else {
           self.resultValue = [self pendingDateCalculateWithFunction:self.functionForCalc];
       }
    }

    self.currentMode = [self modeWithFunction:function];
    if (self.currentMode == ModeFunction) {
        self.functionForCalc = function;
        self.inputValue = [[CalcValue alloc] init];
    } 

    return self.resultValue;
}

- (CalcValue *)numberCalculate
{
    if ([self.inputValue isCleared]) {
        self.inputValue = [CalcValue calcValueWithDecimalNumber:[self.resultValue decimalNumberValue]];
    } 
    NSDecimalNumber *result = [self.numberCalcProcessor calculateWithFunction:self.functionForCalc
                                                                     lOperand:[self.resultValue decimalNumberValue] 
                                                                     rOperand:[self.inputValue decimalNumberValue]];
    return [CalcValue calcValueWithDecimalNumber:result];
}

- (CalcValue *)dateCalculate
{
    if (self.currentMode == ModeEqual && [self.resultValue isNumber]) {
        self.functionForCalc = FunctionPlus;
        [self.inputValue clear];
        return [self numberCalculate];
    }
    
    CalcValue *result = [self.dateCalcProcessor calculateWithFunction:self.functionForCalc
                                                             lOperand:self.resultValue
                                                             rOperand:self.inputValue];
    if ([result isNumber] && self.numberInputForPendingCalc) {
        NSDecimalNumber *numberResult = [self.numberCalcProcessor calculateWithFunction:self.functionForPendingCalc
                                                                               lOperand:self.numberInputForPendingCalc
                                                                               rOperand:[result decimalNumberValue]];
        [self clearPendingCalc];
        return [CalcValue calcValueWithDecimalNumber:numberResult];
    } else {
        return result;
    }
}

- (CalcValue *)pendingDateCalculateWithFunction:(Function)function
{
    if (![self.resultValue isNumber] || [[self.resultValue decimalNumberValue] isEqualToNumber:@0]) {
        self.functionForPendingCalc = FunctionNone;
        self.inputValue = [[CalcValue alloc] init];
        [self clearPendingCalc];
        return self.inputValue;
    }

    self.functionForPendingCalc = function;
    self.numberInputForPendingCalc = [self.resultValue decimalNumberValue];
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
    self.functionForDisplay = FunctionNone;
    self.functionForCalc = FunctionNone;
    self.resultValue = nil;
    self.inputValue = [[CalcValue alloc] init];
    self.currentMode = ModeInput;
    [self clearPendingCalc];
}

- (void)clearPendingCalc
{
    self.functionForPendingCalc = FunctionNone;
    self.numberInputForPendingCalc = nil;
}
@end
