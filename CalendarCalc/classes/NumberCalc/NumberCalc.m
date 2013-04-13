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

- (Result *)calculateWithFunction:(Function)function;
@end

@implementation NumberCalc
- (instancetype)init
{
    if ((self = [super init])) {
        _process = [[NumberCalcProcess alloc] init];
        _result = [[NumberCalcResult alloc] init];
    }
    return self;
}

- (Result *)inputInteger:(NSInteger)integer
{
    return [self.result inputNumberString:[@(integer) stringValue]];
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


#pragma mark - Private

- (Result *)calculateWithFunction:(Function)function
{
    NSDecimalNumber *resultNumber = [self.process calculateWithFunction:self.currentFunction
                                                                operand:[self.result decimalNumberValue]];
    self.currentFunction = function;
    self.result = [[NumberCalcResult alloc] init];
   
    return [Result resultWithDecimalNumber:resultNumber];
}
@end