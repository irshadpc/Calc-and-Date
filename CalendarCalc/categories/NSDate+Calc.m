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
- (NSDate *)addingByYear:(NSInteger)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *ymdComponents = [calendar components:[NSDateComponents componentsYMD]
                                                  fromDate:self];

    [ymdComponents setYear:[ymdComponents year] + year];
    return [calendar dateFromComponents:ymdComponents];
}

- (NSDate *)addingByDay:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *ymdComponents = [calendar components:[NSDateComponents componentsYMD]
                                                  fromDate:self];

    [ymdComponents setDay:[ymdComponents day] + day];
    return [calendar dateFromComponents:ymdComponents];
}

- (NSInteger)dayIntervalWithDate:(NSDate *)date
{
    return [date timeIntervalSinceDate:self] / 60 / 60 / 24;
}
@end
