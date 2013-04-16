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
#import "Function.h"
#import "NSString+Calculator.h"

@interface CalcController ()
@property(strong, nonatomic) NumberCalcProcessor *numberCalcProcessor;
@property(strong, nonatomic) DateCalcProcessor *dateCalcProcessor;
@property(strong, nonatomic) CalcValue *resultValue;
@property(strong, nonatomic) CalcValue *inputValue;
@property(nonatomic) Function currentFunction;
@property(strong, nonatomic) NSDecimalNumber *oldNumberInput;
@property(nonatomic) Function oldFunction;
@property(nonatomic, getter=isEqualMode) BOOL equalMode;

- (NSString *)inputKeyCode:(NSInteger)keycode;
- (NSString *)inputFunction:(Function)function;
- (NSString *)calculateWithFunction:(Function)function;
- (CalcValue *)numberCalculate;
- (CalcValue *)dateCalculate;
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

- (NSString *)inputInteger:(NSInteger)integer
{
    if (integer < FunctionDecimal) {
        return [self inputKeyCode:integer];
    } else {
        return [self inputFunction:integer];
    }
}

- (NSString *)inputDate:(NSDate *)date
{
    if (self.isEqualMode) {
        [self reset];
    }
    [self.inputValue inputDate:date];
    return [self.inputValue stringValue];
}


#pragma mark - Private

- (NSString *)inputKeyCode:(NSInteger)keycode
{
    if (self.isEqualMode) {
        [self reset];
    }
    
    if (keycode == KeyCodeDoubleZero) {
        [self.inputValue inputNumberString:@"00"];
    } else {
        [self.inputValue inputNumberString:[@(keycode) stringValue]];
    }
    return [self.inputValue stringValue];
}

- (NSString *)inputFunction:(Function)function
{
    self.equalMode = function == FunctionEqual;
    switch (function) {
        case FunctionNone:
        case FunctionPlus:
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionDivide:
        case FunctionEqual:
            return [self calculateWithFunction:function];
        case FunctionDecimal:
            [self.inputValue inputDecimalPoint];
            return [self.inputValue stringValue];
        case FunctionClear:
            [self.inputValue clear];
            return [self.inputValue stringValue];
        case FunctionPlusMinus:
            [self.inputValue reverseNumber];
            return [self.inputValue stringValue];
        case FunctionDelete:
            [self.inputValue deleteNumber];
            return [self.inputValue stringValue];
        case FunctionMax:
            NSLog(@"FUNCTION: %d", function);
            abort();
    }
}

- (NSString *)calculateWithFunction:(Function)function
{
    if (!self.resultValue || self.currentFunction == FunctionEqual) {
        self.resultValue = self.inputValue;
        self.inputValue = [[CalcValue alloc] init];
        self.currentFunction = function;
        return [self.resultValue stringValue];
    }

    if ([self.resultValue isNumber] && [self.inputValue isNumber]) {
        self.resultValue = [self numberCalculate];
    } else {
        self.resultValue = [self dateCalculate];
    }

    if (!self.isEqualMode) {
        self.currentFunction = function;
        self.inputValue = [[CalcValue alloc] init];
    } 

    return [self.resultValue stringValue];
}

- (CalcValue *)numberCalculate
{
    NSDecimalNumber *result = [self.numberCalcProcessor calculateWithFunction:self.currentFunction
                                                                     lOperand:[self.resultValue decimalNumberValue] 
                                                                     rOperand:[self.inputValue decimalNumberValue]];
    return [CalcValue calcValueWithDecimalNumber:result];
}

- (CalcValue *)dateCalculate
{
    if (self.currentFunction == FunctionMultiply || self.currentFunction == FunctionDivide) {
        self.oldNumberInput = [self.resultValue decimalNumberValue];
        self.oldFunction = self.currentFunction;
        return self.inputValue;
    }
    
    CalcValue *result = [self.dateCalcProcessor calculateWithFunction:self.currentFunction
                                                             lOperand:self.resultValue
                                                             rOperand:self.inputValue];
    if ([result isNumber] && self.oldNumberInput) {
        NSDecimalNumber *numberResult = [self.numberCalcProcessor calculateWithFunction:self.oldFunction
                                                                               lOperand:[result decimalNumberValue]
                                                                               rOperand:self.oldNumberInput];
        self.oldNumberInput = nil;
        self.oldFunction = FunctionNone;
        return [CalcValue calcValueWithDecimalNumber:numberResult];
    } else {
        return result;
    }
}

- (void)reset
{
    self.currentFunction = FunctionNone;
    self.resultValue = nil;
    self.inputValue = [[CalcValue alloc] init];
    self.oldNumberInput = nil;
    self.equalMode = NO;
}
@end
