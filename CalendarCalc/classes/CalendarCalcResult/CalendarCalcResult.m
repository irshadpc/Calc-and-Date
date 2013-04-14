//
//  CCCalendarCalcResult.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcResult.h"
#import "NumberResult.h"
#import "DateResult.h"
#import "NSString+Locale.h"

@implementation CalendarCalcResult

- (id)init
{
    if ((self = [super init])) {
        _numberResult = [[NumberResult alloc] init];
        _dateResult = [[DateResult alloc] init];
        _calcType = CalcTypeUnknown;
    }
    return self;
}

- (void)endInput
{
    [_numberResult clear];
    [_dateResult clear];
    _calcType = CalcTypeUnknown;
}

- (void)clear
{
    [self endInput];
    _displayResult = nil;
}

- (CalendarCalcResult *)clearEntry
{
    if (_calcType != CalcTypeDate) {
        _calcType = CalcTypeNumber;
        [_numberResult clearEntry];
    } else {
        [_dateResult clear];
    }
    [self updateDisplayResult];
    
    return self;
}

- (void)updateDisplayResult
{
    switch (_calcType) {
        case CalcTypeUnknown:
            break;
        case CalcTypeNumber:
            _displayResult = [_numberResult displayResult];
            break;
        case CalcTypeDate:
            _displayResult = [_dateResult displayResult];
            break;
        case CalcTypeMax:
        default:
            NSLog(@"CALC_TYPE: %d", _calcType);
            abort();
    }
}

- (NSString *)displayResult
{
    if (!_displayResult) {
        return @"0";
    }
    return _displayResult;
}

@end
