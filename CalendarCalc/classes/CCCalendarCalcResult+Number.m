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
    if (!_isNumberResult) {
        return nil;
    }
    
    return [_numberResult result];
}

- (void)setNumberResult:(NSDecimalNumber *)number
{
    if (!number) {
        _isNumberResult = NO;
        return;
    }
    
    [_numberResult setResult:number];
    [self updateDisplayResult];
}

- (CCCalendarCalcResult *)clearEntry
{
    if (_isNumberResult) {
        [_numberResult clearEntry];
    }
    
    return self;
}

- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    [_numberResult inputNumber:number];
    _isNumberResult = YES;
    _isEmpty = NO;
    
    return self;
}

- (CCCalendarCalcResult *)inputDecimalPoint
{
    if (_isNumberResult) {
        [_numberResult inputDecimalPoint];
    }

    return self;
}

- (CCCalendarCalcResult *)reverseNumberResult
{
    if (_isNumberResult) {
        [_numberResult reverse];
    }
    return self;
}

@end