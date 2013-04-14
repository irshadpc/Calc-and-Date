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

- (CalcValue *)calculateWithFunction:(Function)function dateOperand:(NSDate *)lOperand numberOperand:(NSDecimalNumber *)rOperand;
- (CalcValue *)calculateWithFunction:(Function)function dateOperand:(NSDate *)lOperand dateOperand:(NSDate *)rOperand;
- (NSUInteger)excludeDayCountWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
@end

@implementation DateCalcProcessor
- (CalcValue *)calculateWithFunction:(Function)function
                             operand:(CalcValue *)operand
{
    if (!self.oldResult) {
        self.oldResult = operand;
        return self.oldResult;
    }
    
    NSDate *lOperand = nil;
    NSDate *rDateOperand = nil;
    NSDecimalNumber *rNumberOperand = nil;
    if (![self.oldResult isNumber] && ![operand isNumber]) {
        lOperand = [self.oldResult dateValue];
        rDateOperand = [operand dateValue];
    } else if (![self.oldResult isNumber] && [operand isNumber]) {
        lOperand = [self.oldResult dateValue];
        rNumberOperand = [operand decimalNumberValue];
    } else if ([self.oldResult isNumber] && ![operand isNumber]) {
        lOperand = [operand dateValue];
        rNumberOperand = [self.oldResult decimalNumberValue];
    } else {
        abort();
    }

    switch (function) {
        case FunctionPlus:
        case FunctionMinus:
        case FunctionMultiply:
        case FunctionDivide:
            if (rDateOperand) {
                return [self calculateWithFunction:function dateOperand:lOperand dateOperand:rDateOperand];
            } else {
                return [self calculateWithFunction:function dateOperand:lOperand numberOperand:rNumberOperand];
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

    [self setOldResult:[CalcValue calcValueWithDate:[lOperand addingByDay:addingDay]]];
    return self.oldResult;
}

- (CalcValue *)calculateWithFunction:(Function)function
                         dateOperand:(NSDate *)lOperand
                         dateOperand:(NSDate *)rOperand
{
    NSDate *lOperandTMP = nil;
    if (self.isIncludeStartDay) {
        lOperandTMP = [[self.oldResult dateValue] addingByDay:-1];
    } else {
        lOperandTMP = [self.oldResult dateValue];
    }

    NSInteger interval = ABS([lOperandTMP dayIntervalWithDate:[rOperand noTime]]);
    NSInteger calcResult = ABS(interval - [self excludeDayCountWithStartDate:lOperandTMP
                                                                     endDate:[rOperand noTime]]);
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
