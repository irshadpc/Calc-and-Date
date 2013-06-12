//
//  NSString+Calculator.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NSString+Calculator.h"

@implementation NSString (Calculator)
+ (NSString *)stringWithKeyCode:(NSInteger)keyCode
{
    const NSInteger KeyCodeDoubleZero = 10;
    if (keyCode == KeyCodeDoubleZero) {
        return @"00";
    }
    return [@(keyCode) stringValue];
}

+ (NSString *)stringWithFunction:(Function)function
{
    switch (function) {
        case FunctionPlus:
            return @"+";
        case FunctionMinus:
            return @"-";
        case FunctionMultiply:
            return @"×";
        case FunctionDivide:
            return @"÷";
        case FunctionNone:
        case FunctionEqual:
        case FunctionClear:
            return @"";
        default:
            return nil;
    }
}
@end
