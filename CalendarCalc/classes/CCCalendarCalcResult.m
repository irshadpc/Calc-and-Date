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
    }
    return self;
}

- (void)clear
{
    [_numberResult clear];
    [_dateResult clear];
}

@end
