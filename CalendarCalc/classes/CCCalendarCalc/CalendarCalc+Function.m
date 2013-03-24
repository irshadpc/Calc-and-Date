//
//  CCCalendarCalc+Function.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalc+Function.h"
#import "CalendarCalcResult.h"
#import "CalendarCalcResult+Number.h"
#import "CalendarCalcResult+Date.h"
#import "NumberCalculator.h"
#import "DateCalculator.h"

@implementation CalendarCalc (Function)
- (CalendarCalcResult *)clearResult
{
    if (!_isEqual && ([_result numberResult] || [_result dateResult])) {
        [_result clear];
    } else {
        _currentFunction = FunctionNone;
        [_result clear];
        [_numberCalculator clear];
        [_dateCalculator clear];
    }

    return _result;
}

- (CalendarCalcResult *)reverseNumber
{
    if (!_isEqual) {
        [_result reverseNumberResult];
    } else {
        if ([_numberCalculator result]) {
            [_result setNumberResult:[_numberCalculator reverse]];
        } else if ([_dateCalculator numberResult]) {
            [_result setNumberResult:[_dateCalculator reverse]];
        }
    }

    if (_isEqual) {
        [_numberCalculator clear];
        [_dateCalculator clear];
        _currentFunction = FunctionNone;
        _isEqual = NO;
    }
    return _result;
}

- (CalendarCalcResult *)deleteNumber
{
    if (!_isEqual) {
        [_result clearEntry];
    } else {
        [_result clear];
    }

    return _result;
}
@end
