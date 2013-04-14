//
//  DateCalcProcessor.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/13.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "DateCalcProcessor.h"
#import "CalcValue.h"
#import "Function.h"
#import "Week.h"
#import "NSDate+Calc.h"
#import "NSDate+Component.h"
#import "NSDate+Style.h"
#import "NSDecimalNumber+Calc.h"
#import "NSDecimalNumber+Convert.h"
#import "NSNumber+Predicate.h"

@interface DateCalcProcessor ()
@property(strong, nonatomic) CalcValue *oldResult;
@property(strong, nonatomic) NSNumber *oldNumberOperand;
@property(nonatomic) Function oldFunction;

- (CalcValue *)calculateWithFunction:(Function)function numberOperand:(NSDecimalNumber *)operand;
- (CalcValue *)calculateWithFunction:(Function)function dateOperand:(NSDate *)operand;
- (NSUInteger)excludeDayCountWithStartDate:(NSDate *)startDate
                                  endDate:(NSDate *)endDate;
@end

@implementation DateCalcProcessor
- (CalcValue *)calculateWithFunction:(Function)function
                             operand:(CalcValue *)operand
{
    switch (function) {
        case FunctionPlus:
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionDivide:
            if ([operand isNumber]) {
                return [self calculateWithFunction:function
                                     numberOperand:[operand decimalNumberValue]];
            } else {
                return [self calculateWithFunction:function
                                       dateOperand:[operand dateValue]];
            }
        case FunctionEqual:
            [self setOldResult:operand];
            return [self oldResult];
            
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


#pragma mark - Private

- (CalcValue *)calculateWithFunction:(Function)function
                       numberOperand:(NSDecimalNumber *)operand
{
    NSInteger addingDay = 0;
    switch (function) {
        case FunctionPlus:
            addingDay = [operand integerValue];
            break;
        case FunctionMinus:
            addingDay = -[operand integerValue];
            break;
        case FunctionMultiply:
        case FunctionDivide:
        default:
            NSLog(@"FUNCTION: %d", function);
            abort();
    }

    [self setOldResult:[CalcValue calcValueWithDate:[[self.oldResult dateValue] addingByDay:addingDay]]];
    return self.oldResult;
}

- (CalcValue *)calculateWithFunction:(Function)function
                         dateOperand:(NSDate *)operand
{
    NSDate *lOperand = nil;
    if (self.isIncludeStartDay) {
        lOperand = [[self.oldResult dateValue] addingByDay:-1];
    } else {
        lOperand = [self.oldResult dateValue];
    }

    NSInteger interval = ABS([lOperand dayIntervalWithDate:[operand noTime]]);
    NSInteger calcResult = ABS(interval - [self excludeDayCountWithStartDate:lOperand
                                                                     endDate:[operand noTime]]);
    if (function == FunctionMinus) {
        calcResult = -calcResult;
    }

    if (self.oldFunction == FunctionMultiply && self.oldNumberOperand) {
        calcResult *= [[self.oldResult decimalNumberValue] integerValue];
        [self setOldFunction:FunctionNone];
        [self setOldNumberOperand:nil];
    } else if (self.oldFunction == FunctionDivide && self.oldNumberOperand && ![self.oldNumberOperand isEqual:@0]) {
        calcResult /= [self.oldNumberOperand integerValue];
        [self setOldFunction:FunctionNone];
        [self setOldNumberOperand:nil];
    }

    [self setOldResult:[CalcValue calcValueWithNumberString:[@(calcResult) stringValue]
                                              decimalString:nil]];
    return self.oldResult;
}

- (NSUInteger)excludeDayCountWithStartDate:(NSDate *)startDate
                                   endDate:(NSDate *)endDate
{
    if ([self.excludeWeeks count] == 0) {
        return [NSDecimalNumber zero];
    }

    NSDate *minDate, *maxDate;
    if ([startDate compare:endDate] == NSOrderedAscending) {
        minDate = [startDate addingByDay:1];
        maxDate = endDate;
    } else {
        minDate = [endDate addingByDay:1];
        maxDate = startDate;
    }

    NSUInteger excludeDayCount = 0;
    NSInteger weekday = [minDate weekday];
    NSInteger interval = [minDate dayIntervalWithDate:maxDate];
    for (NSInteger day = 0; day <= interval; day++) {
        if (weekday > Saturday) {
            weekday = Sunday;
        }
        if ([self.excludeWeeks containsObject:@(weekday)]) {
            excludeDayCount++;
        }
        weekday++;
    }

    return excludeDayCount;
}
@end
