//
//  CCCalendarCalcResult+Number.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcResult+Number.h"
#import "CCNumberResult.h"
#import "NSNumberFormatter+CalendarCalc.h"

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

- (void)setNumberResultForDisplay:(NSDecimalNumber *)number
{
    if (!number) {
        return;
    }
    _displayResult = [[NSNumberFormatter displayNumberFormatter] stringFromNumber:number];
}

- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    [_numberResult inputNumber:number];
    _calcType = CCNumber;
    [self updateDisplayResult];

    return self;
}

- (CCCalendarCalcResult *)inputDecimalPoint
{
    if (_calcType != CCDate) {
        [_numberResult inputDecimalPoint];
    }
    [self updateDisplayResult];
    
    return self;
}

- (CCCalendarCalcResult *)reverseNumberResult
{
    if (_calcType == CCDate) {
        return self;
    }
   
    if (_calcType == CCUnknown) {
        [self inputNumber:[NSDecimalNumber zero]];
    }
    
    [_numberResult reverse];
    [self updateDisplayResult];
    
    return self;
}

@end