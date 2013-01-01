//
//  NSString+Calculator.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NSString+Calculator.h"

@implementation NSString (Calculator)
+ (NSString *)stringWithFunction:(CCFunction)function
{
    switch (function) {
        case CCPlus:
            return @"+";
        case CCMinus:
            return @"-";
        case CCMultiply:
            return @"×";
        case CCDivide:
            return @"÷";
        case CCEqual:
        case CCClear:
            return @"";
        default:
            return nil;
    }
}
@end
