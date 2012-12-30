//
//  CCCalendarCalcResult.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcResult.h"
#import "CCNumberResult.h"
#import "CCDateResult.h"
#import "NSString+Locale.h"

@implementation CCCalendarCalcResult

- (id)init
{
    if ((self = [super init])) {
        _numberResult = [[CCNumberResult alloc] init];
        _dateResult = [[CCDateResult alloc] init];
        _calcType = CCUnknown;
    }
    return self;
}

- (void)allClear
{
    [self clear];
    _displayResult = nil;
}

- (void)clear
{
    [_numberResult clear];
    [_dateResult clear];
    _calcType = CCUnknown;
}

- (void)setCalcType:(CCCalcType)calcType
{
    _calcType = calcType;
}

- (CCCalendarCalcResult *)clearEntry
{
    if (_calcType != CCDate) {
        _calcType = CCNumber;
        [_numberResult clearEntry];
    } else {
        [_dateResult clear];
    }

    return self;
}

- (void)updateDisplayResult
{
    switch (_calcType) {
        case CCUnknown:
            break;
        case CCNumber:
            _displayResult = [_numberResult displayResult];
            break;
        case CCDate:
            _displayResult = [_dateResult displayResult];
            break;
        case CCCalcMax:
        default:
            NSLog(@"CALC_TYPE: %d", _calcType);
            abort();
    }
}

- (NSString *)displayResult
{
    [self updateDisplayResult];
    if (!_displayResult) {
        return @"0";
    }
    return _displayResult;
}

@end
