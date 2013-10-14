//
//  NSString+CalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NSString+CalendarCalc.h"
#import "NSString+Locale.h"
#import "Week.h"

@implementation NSString (CalendarCalc)
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

+ (NSString *)stringWithWeek:(NSInteger)week
{
    switch (week) {
        case Sunday:    return NSLocalizedString(@"SUN", nil);
        case Monday:    return NSLocalizedString(@"MON", nil);
        case Tuesday:   return NSLocalizedString(@"TUE", nil);
        case Wednesday: return NSLocalizedString(@"WED", nil);
        case Thursday:  return NSLocalizedString(@"THU", nil);
        case Friday:    return NSLocalizedString(@"FRI", nil);
        case Saturday:  return NSLocalizedString(@"SAT", nil);
        default:
            NSLog(@"WEEK: %ld", (long)week);
            abort();
    }
}

+ (NSString *)stringWithYear:(NSInteger)year
                       month:(NSInteger)month
{
    return [NSString stringWithFormat:@"%ld%@%02ld", (long)year, [NSString dateSeparator], (long)month];
}
@end
