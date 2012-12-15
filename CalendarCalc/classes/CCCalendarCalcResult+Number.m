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
    [_numberResult setResult:number];
    [self updateDisplayResult];
}

- (void)clearEntry
{
    [_numberResult clearEntry];
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
    if (!_isNumberResult) {
        return self;
    }
    
    [_numberResult inputDecimalPoint];
    return self;
}

@end