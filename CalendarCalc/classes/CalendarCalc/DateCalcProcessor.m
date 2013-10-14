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
#import "NSDecimalNumber+Safe.h"
#import "NSDecimalNumber+Convert.h"
#import "NSNumber+Predicate.h"

@interface DateCalcProcessor ()
@property(strong, nonatomic) NSNumber *oldNumberOperand;
@property(nonatomic) Function oldFunction;

- (CalcValue *)calculateWithFunction:(Function)function dateOperand:(NSDate *)lOperand numberOperand:(NSDecimalNumber *)rOperand;
- (CalcValue *)calculateWithFunction:(Function)function dateOperand:(NSDate *)lOperand dateOperand:(NSDate *)rOperand;
- (NSUInteger)excludeDayCountWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
@end

@implementation DateCalcProcessor
- (CalcValue *)calculateWithFunction:(Function)function
                            lOperand:(CalcValue *)lOperand
                            rOperand:(CalcValue *)rOperand
{
    NSDate *lDateOperand = nil;
    NSDate *rDateOperand = nil;
    NSDecimalNumber *rNumberOperand = nil;
    if (![lOperand isNumber] && ![rOperand isNumber]) {
        lDateOperand = [lOperand dateValue];
        rDateOperand = [rOperand dateValue];
    } else if (![lOperand isNumber] && [rOperand isNumber]) {
        lDateOperand = [lOperand dateValue];
        rNumberOperand = [rOperand decimalNumberValue];
    } else if ([lOperand isNumber] && ![rOperand isNumber]) {
        lDateOperand = [rOperand dateValue];
        rNumberOperand = [lOperand decimalNumberValue];
    } else {
        abort();
    }

    switch (function) {
        case FunctionPlus:
        case FunctionMinus:
            if (rDateOperand) {
                return [self calculateWithFunction:function dateOperand:lDateOperand dateOperand:rDateOperand];
            } else {
                return [self calculateWithFunction:function dateOperand:lDateOperand numberOperand:rNumberOperand];
            }
        case FunctionMultiply:
        case FunctionDivide:
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


#pragma mark - Private

- (CalcValue *)calculateWithFunction:(Function)function
                         dateOperand:(NSDate *)lOperand
                       numberOperand:(NSDecimalNumber *)rOperand
{
    NSInteger addingDay = 0;
    switch (function) {
        case FunctionPlus:
            addingDay = [rOperand integerValue];
            break;
        case FunctionMinus:
            addingDay = -[rOperand integerValue];
            break;
        case FunctionMultiply:
        case FunctionDivide:
        default:
            NSLog(@"FUNCTION: %d", function);
            abort();
    }

    return [CalcValue calcValueWithDate:[lOperand addingByDay:addingDay]];
}

- (CalcValue *)calculateWithFunction:(Function)function
                         dateOperand:(NSDate *)lOperand
                         dateOperand:(NSDate *)rOperand
{
    NSDate *lOperandTMP = nil;
    if (self.isIncludeStartDay) {
        lOperandTMP = [lOperand addingByDay:-1];
    } else {
        lOperandTMP = lOperand;
    }

    NSInteger interval = ABS([lOperandTMP dayIntervalWithDate:[rOperand noTime]]);
    NSInteger calcResult = ABS(interval - [self excludeDayCountWithStartDate:lOperandTMP
                                                                     endDate:[rOperand noTime]]);
    if (function == FunctionMinus) {
        calcResult = -calcResult;
    }

    if (self.oldFunction == FunctionMultiply && self.oldNumberOperand) {
        calcResult *= [self.oldNumberOperand integerValue];
        [self setOldFunction:FunctionNone];
        [self setOldNumberOperand:nil];
    } else if (self.oldFunction == FunctionDivide && self.oldNumberOperand && ![self.oldNumberOperand isEqual:@0]) {
        calcResult /= [self.oldNumberOperand integerValue];
        [self setOldFunction:FunctionNone];
        [self setOldNumberOperand:nil];
    }

    return [CalcValue calcValueWithNumberString:[@(calcResult) stringValue]
                                  decimalString:nil];
}

- (NSUInteger)excludeDayCountWithStartDate:(NSDate *)startDate
                                   endDate:(NSDate *)endDate
{
    if ([self.excludeWeeks count] == 0) {
        return 0;
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
