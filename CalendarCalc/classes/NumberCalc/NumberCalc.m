//
//  NumberCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/11.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NumberCalc.h"
#import "NumberCalcProcessor.h"
#import "NumberCalcResult.h"
#import "CalcValue.h"

@interface NumberCalc ()
@property(nonatomic) Function currentFunction;
@property(strong, nonatomic) NumberCalcProcessor *process;
@property(strong, nonatomic) NumberCalcResult *result;

- (CalcValue *)inputInteger:(NSInteger)integer;
- (CalcValue *)inputFunction:(Function)function;
- (CalcValue *)calculateWithFunction:(Function)function;
@end

@implementation NumberCalc
static const NSInteger DOUBLE_ZERO = 10;

- (instancetype)init
{
    if ((self = [super init])) {
        _process = [[NumberCalcProcessor alloc] init];
        _result = [[NumberCalcResult alloc] init];
    }
    return self;
}

- (CalcValue *)input:(NSInteger)value
{
    if (value < FunctionDecimal) {
        return [self inputInteger:value];
    } else {
        return [self inputFunction:value];
    }
}


#pragma mark - Private

- (CalcValue *)inputInteger:(NSInteger)integer
{
    NSString *numberString = nil;
    if (integer == DOUBLE_ZERO) {
        numberString = @"00";
    } else {
        numberString = [@(integer) stringValue];
    }
    
    return [self.result inputNumberString:numberString];
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
            return [self.result inputDecimalPoint];
        case FunctionClear:
            return [self.result clear];
        case FunctionPlusMinus:
            return [self.result reverseNumber];
        case FunctionDelete:
            return [self.result deleteNumber];
        case FunctionMax:
            NSLog(@"FUNCTION: %d", function);
            abort();
    }
}

- (CalcValue *)calculateWithFunction:(Function)function
{
    NSDecimalNumber *resultNumber = [self.process calculateWithFunction:self.currentFunction
                                                                operand:[self.result decimalNumberValue]];
    [self setCurrentFunction:function];
    [self setResult:[[NumberCalcResult alloc] init]];
   
    return [CalcValue calcValueWithDecimalNumber:resultNumber];
}
@end