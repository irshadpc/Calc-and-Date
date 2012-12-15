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
        _isEmpty = YES;
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
    _isEmpty = YES;
}

- (void)updateDisplayResult
{
    if (_isEmpty) {
        return;
    }

    if (_isNumberResult) {
        _displayResult = [_numberResult displayResult];
    } else {
        _displayResult = [_dateResult displayResult];
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
