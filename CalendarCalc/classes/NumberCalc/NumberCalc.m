//
//  NumberCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/11.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NumberCalc.h"
#import "NumberCalcProcess.h"
#import "NumberCalcResult.h"
#import "Result.h"

@interface NumberCalc ()
@property(nonatomic) Function currentFunction;
@property(strong, nonatomic) NumberCalcProcess *process;
@property(strong, nonatomic) NumberCalcResult *result;

- (Result *)inputInteger:(NSInteger)integer;
- (Result *)inputFunction:(Function)function;
- (Result *)calculateWithFunction:(Function)function;
@end

@implementation NumberCalc
static const NSInteger DOUBLE_ZERO = 10;

- (instancetype)init
{
    if ((self = [super init])) {
        _process = [[NumberCalcProcess alloc] init];
        _result = [[NumberCalcResult alloc] init];
    }
    return self;
}

- (Result *)input:(NSInteger)value
{
    if (value < FunctionDecimal) {
        return [self inputInteger:value];
    } else {
        return [self inputFunction:value];
    }
}


#pragma mark - Private

- (Result *)inputInteger:(NSInteger)integer
{
    NSString *numberString = nil;
    if (integer == DOUBLE_ZERO) {
        numberString = @"00";
    } else {
        numberString = [@(integer) stringValue];
    }
    
    return [self.result inputNumberString:numberString];
}

- (Result *)inputFunction:(Function)function
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

- (Result *)calculateWithFunction:(Function)function
{
    NSDecimalNumber *resultNumber = [self.process calculateWithFunction:self.currentFunction
                                                                operand:[self.result decimalNumberValue]];
    self.currentFunction = function;
    self.result = [[NumberCalcResult alloc] init];
   
    return [Result resultWithDecimalNumber:resultNumber];
}
@end