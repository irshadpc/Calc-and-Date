//
//  CCCalendarCalc+Function.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalc+Function.h"
#import "CCCalendarCalcResult.h"
#import "CCCalendarCalcResult+Number.h"
#import "CCCalendarCalcResult+Date.h"
#import "CCNumberCalculator.h"
#import "CCDateCalculator.h"

@implementation CCCalendarCalc (Function)
- (CCCalendarCalcResult *)clearResult
{
    if (!_isEqual && ([_result numberResult] || [_result dateResult])) {
        [_result clear];
    } else {
        _currentFunction = CCFunctionNone;
        [_result clear];
        [_numberCalculator clear];
        [_dateCalculator clear];
    }

    return _result;
}

- (CCCalendarCalcResult *)reverseNumber
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
        _isEqual = NO;
    }
    return _result;
}

- (CCCalendarCalcResult *)deleteNumber
{
    if (!_isEqual) {
        [_result clearEntry];
    } else {
        [_result clear];
    }

    return _result;
}
@end
