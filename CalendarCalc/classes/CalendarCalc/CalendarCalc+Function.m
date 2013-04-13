//
//  CCCalendarCalc+Function.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalc+Function.h"
#import "CalendarCalcResult.h"
#import "CalendarCalcResult+Number.h"
#import "CalendarCalcResult+Date.h"
#import "NumberCalculator.h"
#import "DateCalculator.h"

@implementation CalendarCalc (Function)
- (CalendarCalcResult *)clearResult
{
    if (!self.isEqual && ([self.result numberResult] || [self.result dateResult])) {
        [self.result clear];
    } else {
        self.currentFunction = FunctionNone;
        [self.result clear];
        [self.numberCalculator clear];
        [self.dateCalculator clear];
    }

    return self.result;
}

- (CalendarCalcResult *)reverseNumber
{
    if (!self.isEqual) {
        [self.result reverseNumberResult];
    } else {
        if ([self.numberCalculator result]) {
            [self.result setNumberResult:[self.numberCalculator reverse]];
        } else if ([self.dateCalculator numberResult]) {
            [self.result setNumberResult:[self.dateCalculator reverse]];
        }
    }

    if (self.isEqual) {
        [self.numberCalculator clear];
        [self.dateCalculator clear];
        self.currentFunction = FunctionNone;
        self.equal = NO;
    }
    return self.result;
}

- (CalendarCalcResult *)deleteNumber
{
    if (!self.isEqual) {
        [self.result clearEntry];
    } else {
        [self.result clear];
    }

    return self.result;
}
@end
