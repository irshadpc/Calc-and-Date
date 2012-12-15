//
//  CCCalendarCalcResult+Formatter.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcResult+Formatter.h"
#import "CCNumberResult.h"
#import "CCDateResult.h"

@implementation CCCalendarCalcResult (Formatter)

- (NSString *)displayResult 
{
    if (_isNumberResult) {
        return [_numberResult displayResult];
    } else {
        return [_dateResult displayResult];
    }
}

@end
