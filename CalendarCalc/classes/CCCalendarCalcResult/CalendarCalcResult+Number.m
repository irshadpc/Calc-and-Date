//
//  CCCalendarCalcResult+Number.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcResult+Number.h"
#import "NumberResult.h"

@implementation CalendarCalcResult (Number)

+ (NSDecimalNumber *)numberFromString:(NSString *)string
{
    return [NumberResult numberFromString:string];
}

- (NSDecimalNumber *)numberResult
{
    if (_calcType != CalcTypeNumber) {
        return nil;
    }
    
    return [_numberResult result];
}

- (void)setNumberResult:(NSDecimalNumber *)number
{
    if (!number) {
        return;
    }

    _calcType = CalcTypeNumber;
    [_numberResult setResult:number];
    [self updateDisplayResult];
}

- (void)setNumberResultForDisplay:(NSDecimalNumber *)number
{
    if (!number) {
        return;
    }
    _displayResult = [NumberResult stringFromNumber:number];
}

- (CalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    [_numberResult inputNumber:number];
    _calcType = CalcTypeNumber;
    [self updateDisplayResult];

    return self;
}

- (CalendarCalcResult *)inputDecimalPoint
{
    if (_calcType != CalcTypeDate) {
        [_numberResult inputDecimalPoint];
        _calcType = CalcTypeNumber;
    }
    [self updateDisplayResult];
    
    return self;
}

- (CalendarCalcResult *)reverseNumberResult
{
    if (_calcType == CalcTypeDate) {
        return self;
    }
   
    if (_calcType == CalcTypeUnknown) {
        [self inputNumber:[NSDecimalNumber zero]];
    }
    
    [_numberResult reverse];
    [self updateDisplayResult];
    
    return self;
}

@end