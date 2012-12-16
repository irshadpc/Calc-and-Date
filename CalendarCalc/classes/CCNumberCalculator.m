//
//  CCCalendarCalc+Number.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCNumberCalculator.h"
#import "NSDecimalNumber+Calc.h"
#import "NSDecimalNumber+Convert.h"

typedef NSDecimalNumber * (^CCCalcMethod)(NSDecimalNumber *, NSDecimalNumber *);

@interface CCNumberCalculator ()
- (NSDecimalNumber *)calculateWithOperand:(NSDecimalNumber *)rOperand method:(CCCalcMethod)method;
@end

@implementation CCNumberCalculator

////////////////////////////////////////////////////////////////////////////////
- (void)clear
{
    _result = nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)plus:(NSDecimalNumber *)rOperand
{
    return [self calculateWithOperand: rOperand
                               method: ^(NSDecimalNumber *l, NSDecimalNumber *r) {
                                   return [NSDecimalNumber addingByDecimalNumber:l rOperand:r];
                               }];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)minus:(NSDecimalNumber *)rOperand
{
    return [self calculateWithOperand: rOperand
                               method: ^(NSDecimalNumber *l, NSDecimalNumber *r) {
                                   return [NSDecimalNumber subtractingByDecimalNumber:l rOperand:r];
                               }];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)multiply:(NSDecimalNumber *)rOperand
{
    return [self calculateWithOperand: rOperand
                               method: ^(NSDecimalNumber *l, NSDecimalNumber *r) {
                                   return [NSDecimalNumber multiplyingByDecimalNumber:l rOperand:r];
                               }];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)divide:(NSDecimalNumber *)rOperand
{
    return [self calculateWithOperand: rOperand
                               method: ^(NSDecimalNumber *l, NSDecimalNumber *r) {
                                   return [NSDecimalNumber dividingByDecimalNumber:l rOperand:r];
                               }];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)reverse
{
    if (!_result) {
        return nil;
    }
    _result = [NSDecimalNumber reverse:_result];
    return _result;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)setResult:(NSDecimalNumber *)result
{
    if (!result) {
        return nil;
    }

    _result = result;
    return _result;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)result
{
    return _result;
}


#pragma mark - private

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)calculateWithOperand:(NSDecimalNumber *)rOperand
                                   method:(CCCalcMethod)method
{
    if (!rOperand) {
        return nil;
    }
    
    _result = method(_result, rOperand);
    return _result;
}

@end