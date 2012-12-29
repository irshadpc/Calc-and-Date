//
//  CCCalendarCalcResult+Number.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcResult+Number.h"
#import "CCNumberResult.h"

@implementation CCCalendarCalcResult (Number)

- (NSDecimalNumber *)numberResult
{
    if (_calcType != CCNumber) {
        return nil;
    }
    
    return [_numberResult result];
}

- (void)setNumberResult:(NSDecimalNumber *)number
{
    if (!number) {
        return;
    }

    _calcType = CCNumber;
    [_numberResult setResult:number];
    [self updateDisplayResult];
}

- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    [_numberResult inputNumber:number];
    _calcType = CCNumber;
    
    return self;
}

- (CCCalendarCalcResult *)inputDecimalPoint
{
    if (_calcType != CCDate) {
        [_numberResult inputDecimalPoint];
    }

    return self;
}

- (CCCalendarCalcResult *)reverseNumberResult
{
    if (_calcType != CCDate) {
        [_numberResult reverse];
        _calcType = CCNumber;
    }
    return self;
}

@end