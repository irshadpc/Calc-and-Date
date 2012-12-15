//
//  CCCalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalc.h"
#import "CCCalendarCalcResult.h"
#import "CCCalendarCalcResult+Number.h"
#import "CCCalendarCalcResult+Date.h"
#import "CCCalendarCalcResult+Formatter.h"
#import "CCNumberCalculator.h"
#import "CCDateCalculator.h"

typedef enum {
    CCUnknown,
    CCNumber,
    CCDate,

    CCCalcMax
} CCCalcType;

@interface CCCalendarCalc ()
- (void)numberCalculate;
- (void)dateCalculate;
- (CCCalcType)calcType;
@end

@implementation CCCalendarCalc

- (id)init 
{
    if ((self = [super init])) {
        _numberCalculator = [[CCNumberCalculator alloc] init];
        _dateCalculator  = [[CCDateCalculator alloc] init];
        _result = [[CCCalendarCalcResult alloc] init];
    }
    return self;
}

- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    return [_result inputNumber:number];
}

- (CCCalendarCalcResult *)inputDate:(NSDate *)date
{
    return [_result inputDate:date];
}

- (CCCalendarCalcResult *)inputFunction:(CCFunction)function
{
    switch ([self calcType]) {
        case CCUnknown:
            [_numberCalculator setResult:[_result numberResult]];
            [_dateCalculator setDateRusult:[_result dateResult]];
            [_dateCalculator setNumberResult:[_result numberResult]];
            [_result clear];
            break;
        case CCNumber:
            [self numberCalculate];
            break;
        case CCDate:
            [self dateCalculate];
            break;
        default:
            NSLog(@"CALC_TYPE: %d", [self calcType]);
            abort();
    }
    _currentFunction = function;
    
    return _result;
}


#pragma mark - Private

- (void)numberCalculate
{
    switch (_currentFunction) {
        case CCPlus:
            [_numberCalculator plus:[_result numberResult]];
            break;
        case CCMinus:
            [_numberCalculator minus:[_result numberResult]];
            break;
        case CCMultiply:
            [_numberCalculator multiply:[_result numberResult]];
            break;
        case CCDivide:
            [_numberCalculator divide:[_result numberResult]];
            break;
        case CCEqual:
            return;
        default:
            NSLog(@"FUNCTION: %d", _currentFunction);
            abort();
    }

    [_result setNumberResult: [_numberCalculator result]];
}

- (void)dateCalculate
{
    switch (_currentFunction) {
        case CCPlus:
            break;
        case CCMinus:
            break;
        default:
            NSLog(@"FUNCTION: %d", _currentFunction);
            abort();
    }
    
    [_result setDateResult:[_dateCalculator dateResult]];
}

- (CCCalcType)calcType
{
    if ([_dateCalculator dateResult]) {
        return CCDate;
    } else if ([_dateCalculator numberResult] || [_numberCalculator result]) {
        return CCNumber;
    } else {
        return CCUnknown;
    }
}

@end