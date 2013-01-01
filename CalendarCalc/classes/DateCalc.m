//
//  DateCalc.m
//  CalendarCalc
//
//  Created by 純一 石田 on 12/07/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DateCalc.h"
#import "NSDate+util.h"
#import "NSDecimalNumber+util.h"

@interface DateCalc()
- (NSDecimalNumber *)weekCountWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
@end

@implementation DateCalc

@synthesize weekStates = _weekStates;

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)equalWithDate:(NSDate *)rOperand {
    if (!rOperand) {
        return nil;
    }
    isDateResult = YES;
    dateResult = [NSDate firstTimeOfDate:rOperand];
    return dateResult;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)equalWithNumber:(NSDecimalNumber *)rOperand {
    if (!rOperand) {
        return nil;
    }
    isDateResult = NO;
    numberResult = rOperand;
    return numberResult;
}

////////////////////////////////////////////////////////////////////////////////
- (void)clear {
    numberResult = nil;
    dateResult = nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)dateResult {
    return isDateResult ? dateResult : nil;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)numberResult {
    return isDateResult ? nil : numberResult;
}

#pragma mark - number //{{{ number
////////////////////////////////////////////////////////////////////////////////
- (NSDate *)plusWithNumber:(NSDecimalNumber *)rOperand {
    if (!rOperand || !dateResult) {
        return nil;
    }

    isDateResult = YES;
    dateResult = [dateResult addingByDay:rOperand.integerValue];
    return dateResult;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)minusWithNumber:(NSDecimalNumber *)rOperand {
    if (!rOperand || !dateResult) {
        return nil;
    }

    isDateResult = YES;
    dateResult = [dateResult subtractingByDay:rOperand.integerValue];
    return dateResult;
}
//}}}

#pragma mark - date //{{{ date

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)plusWithDate:(NSDate *)rOperand {
    if (!rOperand) {
        return nil;
    }
    
    NSDate *firstTimeDate = [NSDate firstTimeOfDate:rOperand];
    if(!dateResult && !numberResult) {
        isDateResult = YES;
        dateResult = firstTimeDate;
        return nil;
    } else if (!dateResult) {
        dateResult = firstTimeDate;
        [self plusWithNumber:numberResult];
        return nil;
    }

    isDateResult = NO;
    numberResult = [NSDecimalNumber decimalNumberWithNumber:[NSDate dateInterval:dateResult endDate:firstTimeDate]];
    if ([NSDecimalNumber isMinus:numberResult]) {
        numberResult = [NSDecimalNumber negate:numberResult];
    }
    
    numberResult = [NSDecimalNumber subtractingByDecimalNumber:numberResult
                                                              rOperand:[self weekCountWithStartDate:dateResult
                                                                                            endDate:firstTimeDate]];

    if ([NSDecimalNumber isMinus:numberResult]) {
        numberResult = [NSDecimalNumber negate:numberResult];
    }

    dateResult = nil;
    return numberResult;
}

////////////////////////////////////////////////////////////////////////////////
- (NSDecimalNumber *)minusWithDate:(NSDate *)rOperand {
    if (!rOperand) {
        return nil;
    }
    
    NSDate *firstTimeDate = [NSDate firstTimeOfDate:rOperand];
    if (!dateResult && !numberResult) {
        isDateResult = YES;
        dateResult = firstTimeDate;
        return nil;
    } else if (!dateResult) {
        dateResult = firstTimeDate;
        [self minusWithNumber:numberResult];
        return nil;
    }

    isDateResult = NO;
    numberResult = [NSDecimalNumber decimalNumberWithNumber:[NSDate dateInterval:dateResult endDate:firstTimeDate]];
    if ([NSDecimalNumber isMinus:numberResult]) {
        numberResult = [NSDecimalNumber negate:numberResult];
    }
    
    
    numberResult = [NSDecimalNumber subtractingByDecimalNumber:numberResult
                                                      rOperand:[self weekCountWithStartDate:dateResult
                                                                                    endDate:firstTimeDate]];
        
    
    if (![NSDecimalNumber isMinus:numberResult]) {
        numberResult = [NSDecimalNumber negate:numberResult];
    }

    dateResult = nil;
    return numberResult;
}
//}}}

- (NSDecimalNumber *)weekCountWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDate *minDate, *maxDate;
    if ([startDate compare:endDate] <= 0) {
        minDate = [startDate addingByDay:1];
        maxDate = endDate;
    } else {
        minDate = [endDate addingByDay:1];
        maxDate = startDate;
    }
    
    NSMutableArray *disabledWeeks = [[NSMutableArray alloc] init];
    for (NSInteger weekStatIndex = 0; weekStatIndex < 7; weekStatIndex++) {
        if (![[self.weekStates objectAtIndex:weekStatIndex] boolValue]) {
            [disabledWeeks addObject:[NSNumber numberWithInteger:weekStatIndex + 1]];
        }
    }
    
    if ([disabledWeeks count] == 0) {
        disabledWeeks = nil;
        return [NSDecimalNumber zero];
    }
    
    NSInteger weekCount = 0;
    NSInteger weekday = [minDate weekday];
    NSInteger interval = [[NSDate dateInterval:minDate endDate:maxDate] integerValue];
    for (NSInteger day = 0; day <= interval; day++) {
        if (weekday > 7) {
            weekday = 1;
        }
        if ([disabledWeeks indexOfObject:[NSNumber numberWithInteger:weekday]] != NSNotFound) {
            weekCount++;
        }
        weekday++;
    }
    disabledWeeks = nil;
    return [NSDecimalNumber decimalNumberWithInteger:weekCount];
}
@end
