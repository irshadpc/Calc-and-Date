//
//  CCCalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalc.h"
#import "CCCalendarCalcResult.h"
#import "CCNumberCalculator.h"
#import "CCDateCalculator.h"

typedef enum {
    CCNone,
    CCNumber,
    CCDate,

    CCCalcMax
} CCCalcType;

@interface CCCalendarCalc ()
- (CCCalcType)calcType;
@end

@implementation CCCalendarCalc

- (id)init 
{
    if ((self = [super init])) {
        _numberCalculator = [[CCNumberCalculator alloc] init];
        _dateCalculator  = [[CCDateCalculator alloc] init];
    }
    return self;
}

- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    switch ([self calcType]) {
        case CCNone:
            return nil;
        case CCNumber:
            return nil;
        case CCDate:
            return nil;
        default:
            abort();
    }
}

- (CCCalendarCalcResult *)inputDate:(NSDate *)date
{
    switch ([self calcType]) {
        case CCNone:
            return nil;
        case CCNumber:
            return nil;
        case CCDate:
            return nil;
        default:
            abort();
    }
}

- (CCCalendarCalcResult *)inputFunction:(CCFunction)function
{
    switch ([self calcType]) {
        case CCNone:
            return nil;
        case CCNumber:
            return nil;
        case CCDate:
            return nil;
        default:
            abort();
    }
}


#pragma mark - Private

- (CCCalcType)calcType {
    return CCCalcMax;
}

@end