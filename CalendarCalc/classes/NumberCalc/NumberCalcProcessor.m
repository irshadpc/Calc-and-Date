//
//  NumberCalcProcessor.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/11.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NumberCalcProcessor.h"
#import "NSDecimalNumber+Calc.h"
#import "NSDecimalNumber+Convert.h"


typedef NSDecimalNumber * (^Calculate)(NSDecimalNumber *, NSDecimalNumber *);

@interface NumberCalcProcessor()
@property(strong, nonatomic) NSDecimalNumber *oldResult;

- (NSDecimalNumber *)calculateWithOperand:(NSDecimalNumber *)rOperand calculate:(Calculate)calculate;
@end

@implementation NumberCalcProcessor
- (NSDecimalNumber *)calculateWithFunction:(Function)function
                                   operand:(NSDecimalNumber *)operand
{
    if (!self.oldResult) {
        self.oldResult = operand;
        return self.oldResult;
    }
    
    switch (function) {
        case FunctionPlus:
            return [self calculateWithOperand:operand
                                    calculate:^(NSDecimalNumber *l, NSDecimalNumber *r) {
                                        return [NSDecimalNumber addingByDecimalNumber:l rOperand:r];
                                    }];
        case FunctionMinus:
            return [self calculateWithOperand:operand
                                    calculate:^(NSDecimalNumber *l, NSDecimalNumber *r) {
                                        return [NSDecimalNumber subtractingByDecimalNumber:l rOperand:r];
                                    }];
        case FunctionMultiply:
            return [self calculateWithOperand:operand
                                    calculate:^(NSDecimalNumber *l, NSDecimalNumber *r) {
                                        return [NSDecimalNumber multiplyingByDecimalNumber:l rOperand:r];
                                    }];
        case FunctionDivide:
            return [self calculateWithOperand:operand
                                    calculate:^(NSDecimalNumber *l, NSDecimalNumber *r) {
                                        return [NSDecimalNumber dividingByDecimalNumber:l rOperand:r];
                                    }];
        case FunctionEqual:
            self.oldResult = operand;
            return self.oldResult;
            
        case FunctionDecimal:
        case FunctionClear:
        case FunctionPlusMinus:
        case FunctionDelete:
        case FunctionMax:
        default:
            NSLog(@"FUNCTION: %d", function);
            abort();
    }
}

- (NSDecimalNumber *)calculateWithOperand:(NSDecimalNumber *)operand calculate:(Calculate)calculate
{
    if (!operand) {
        return self.oldResult;
    }

    self.oldResult = calculate(self.oldResult, operand);
    return self.oldResult;
}
@end
