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

- (NSString *)inputKeyCode:(NSInteger)keycode;
- (NSString *)inputFunction:(Function)function;
- (NSString *)calculateWithFunction:(Function)function;
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
    [self.inputValue inputDate:date];
    return [self.inputValue stringValue];
}


#pragma mark - Private

- (NSString *)inputKeyCode:(NSInteger)keycode
{
    if (keycode == KeyCodeDoubleZero) {
        [self.inputValue inputNumberString:@"00"];
    } else {
        [self.inputValue inputNumberString:[@(keycode) stringValue]];
    }
    return [self.inputValue stringValue];
}

- (NSString *)inputFunction:(Function)function
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
        NSDecimalNumber *result = [self.numberCalcProcessor calculateWithFunction:self.currentFunction
                                                                         lOperand:[self.resultValue decimalNumberValue]
                                                                         rOperand:[self.inputValue decimalNumberValue]];
        self.resultValue = [CalcValue calcValueWithDecimalNumber:result];
    } else {
        self.resultValue = [self.dateCalcProcessor calculateWithFunction:self.currentFunction
                                                                lOperand:self.resultValue
                                                                rOperand:self.inputValue];
    }
   
    self.currentFunction = function;
    self.inputValue = [[CalcValue alloc] init];

    return [self.resultValue stringValue];
}
@end
