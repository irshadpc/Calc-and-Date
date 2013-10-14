//
//  NumberCalcProcessor.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/11.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NumberCalcProcessor.h"
#import "NSDecimalNumber+Safe.h"

@implementation NumberCalcProcessor
- (NSDecimalNumber *)calculateWithFunction:(Function)function
                                  lOperand:(NSDecimalNumber *)lOperand
                                  rOperand:(NSDecimalNumber *)rOperand
{
    switch (function) {
        case FunctionPlus:
            return [NSDecimalNumber addingByDecimalNumber:lOperand rOperand:rOperand];
        case FunctionMinus:
            return [NSDecimalNumber subtractingByDecimalNumber:lOperand rOperand:rOperand];
        case FunctionMultiply:
            return [NSDecimalNumber multiplyingByDecimalNumber:lOperand rOperand:rOperand];
        case FunctionDivide:
            return [NSDecimalNumber dividingByDecimalNumber:lOperand rOperand:rOperand];
        case FunctionNone:
        case FunctionEqual:
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
@end
