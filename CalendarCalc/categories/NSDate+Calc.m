//
//  NSDate+Calc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDate+Calc.h"
#import "NSDateComponents+Unit.h"

@implementation NSDate (Calc)

////////////////////////////////////////////////////////////////////////////////
- (NSDate *)addingByDay:(NSInteger)day
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components: [NSDateComponents componentsYMD]
                                                                       fromDate: self];
    dateComponents.day += day;

    return [[NSCalendar currentCalendar] dateFromComponents: dateComponents];
}

////////////////////////////////////////////////////////////////////////////////
- (NSInteger)dayIntervalWithDate:(NSDate *)date
{
    return (NSInteger) ([date timeIntervalSinceDate: self] / 60 / 60 / 24);
}

@end
