//
//  CCCalendarCalc+Number.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCNumberCalculator.h"
#import "NSDecimalNumber+Calc.h"

@interface CCNumberCalculator ()
- (NSDecimalNumber *)calculateWithOperand:(NSDecimalNumber *)rOperand method:(SEL)method;
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
                               method: @selector(addingByDecimalNumber:rOperand:)];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)minus:(NSDecimalNumber *)rOperand
{
    return [self calculateWithOperand: rOperand 
                               method: @selector(subtractingByDecimalNumber:rOperand:)];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)multiply:(NSDecimalNumber *)rOperand
{
    return [self calculateWithOperand: rOperand
                               method: @selector(multiplyingByDecimalNumber:rOperand:)];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)divide:(NSDecimalNumber *)rOperand
{
    return [self calculateWithOperand: rOperand 
                               method: @selector(dividingByDecimalNumber:rOperand:)];
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)equal:(NSDecimalNumber *)rOperand
{
    if (!rOperand) {
        return nil;
    }

    _result = rOperand;
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
                                   method:(SEL)method
{
    if (!rOperand) {
        return nil;
    }
    
    _result = [NSDecimalNumber performSelector: method
                                    withObject: rOperand];
    return _result;
}

@end