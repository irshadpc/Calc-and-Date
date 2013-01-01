//
//  CCCalendarCalcFormatter.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcFormatter.h"
#import "CCCalendarCalc.h"
#import "CCCalendarCalcResult.h"
#import "NSString+Calculator.h"

@implementation CCCalendarCalcFormatter

- (id)initWithCalendarCalc:(CCCalendarCalc *)calendarCalc
{
    if ((self = [super init])) {
        _calendarCalc = calendarCalc;
    }
    return self;
}

- (NSString *)displayResult 
{
    return [[self.calendarCalc result] displayResult];
}

- (NSString *)displayIndicator
{
    if (self.calendarCalc.lastFunction == CCClear && !self.calendarCalc.isAllCleared) {
        return _cachedIndicator;
    }
    
    NSString *indicator = [NSString stringWithFunction:self.calendarCalc.lastFunction];
    if (indicator) {
        _cachedIndicator = indicator;
    }
    return _cachedIndicator;
}

- (NSString *)displayClearButtonTitle
{
    if (self.calendarCalc.isAllCleared) {
        return @"AC";
    } else {
        return @"C";
    }
}

@end
