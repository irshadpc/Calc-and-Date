//
//  NSDecimalNumber+Calc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDecimalNumber+Calc.h"

typedef NSCalculationError (^DecimalCalculate)(NSDecimal *, const NSDecimal *, const NSDecimal *, NSRoundingMode);

@interface NSDecimalNumber (CalcPrivate)
+ (NSDecimalNumber *)calculateByDecimalNumber:(NSDecimalNumber *)lOperand
                                     rOperand:(NSDecimalNumber *)rOperand
                                       method:(DecimalCalculate)method;
@end

@implementation NSDecimalNumber (Calc)
+ (NSDecimalNumber *)addingByDecimalNumber:(NSDecimalNumber *)lOperand
                                  rOperand:(NSDecimalNumber *)rOperand
{
    return [self calculateByDecimalNumber: lOperand
                                 rOperand: rOperand
                                   method: ^(NSDecimal *result, const NSDecimal *l, const NSDecimal *r, NSRoundingMode roundingMode) {
                                       return NSDecimalAdd(result, l, r, roundingMode);
                                   }];
}

+ (NSDecimalNumber *)subtractingByDecimalNumber:(NSDecimalNumber *)lOperand
                                       rOperand:(NSDecimalNumber *)rOperand
{
    return [self calculateByDecimalNumber: lOperand
                                 rOperand: rOperand
                                   method: ^(NSDecimal *result, const NSDecimal *l, const NSDecimal *r, NSRoundingMode roundingMode) {
                                       return NSDecimalSubtract(result, l, r, roundingMode);
                                   }];
}

+ (NSDecimalNumber *)multiplyingByDecimalNumber:(NSDecimalNumber *)lOperand
                                       rOperand:(NSDecimalNumber *)rOperand
{
    return [self calculateByDecimalNumber: lOperand
                                 rOperand: rOperand
                                   method: ^(NSDecimal *result, const NSDecimal *l, const NSDecimal *r, NSRoundingMode roundingMode) {
                                       return NSDecimalMultiply(result, l, r, roundingMode);
                                   }];
}

+ (NSDecimalNumber *)dividingByDecimalNumber:(NSDecimalNumber *)lOperand
                                    rOperand:(NSDecimalNumber *)rOperand
{
    return [self calculateByDecimalNumber: lOperand
                                 rOperand: rOperand
                                   method: ^(NSDecimal *result, const NSDecimal *l, const NSDecimal *r, NSRoundingMode roundingMode) {
                                       return NSDecimalDivide(result, l, r, roundingMode);
                                   }];
}

@end


@implementation NSDecimalNumber (CalcPrivate)
+ (NSDecimalNumber *)calculateByDecimalNumber:(NSDecimalNumber *)lOperand
                                     rOperand:(NSDecimalNumber *)rOperand
                                       method:(DecimalCalculate)method
{
    NSDecimal l = [[NSDecimalNumber zero] decimalValue];
    if (lOperand) {
        l = [lOperand decimalValue];
    }

    NSDecimal r = [[NSDecimalNumber zero] decimalValue];
    if (rOperand) {
        r = [rOperand decimalValue];
    }

    NSDecimal result = [[NSDecimalNumber zero] decimalValue];
    method(&result, &l, &r, NSRoundDown);
    if (NSDecimalIsNotANumber(&result)) {
        return [NSDecimalNumber zero];
    }

    return [NSDecimalNumber decimalNumberWithDecimal: result];
}
@end
