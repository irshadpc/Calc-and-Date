//
//  NSNumberFormatter+CalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSNumberFormatter+CalendarCalc.h"
#import "NumberFormat.h"

@implementation NSNumberFormatter (CalendarCalc)
+ (NSNumberFormatter *)displayLongNumberFormatter
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:MaxDigits];
    return numberFormatter;
}

+ (NSNumberFormatter *)displayShortNumberFormatter
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    [numberFormatter setMaximumFractionDigits:MaxDigits];
    return numberFormatter;
}

+ (NSNumberFormatter *)plainNumberFormatter
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterNoStyle];
    [numberFormatter setMaximumFractionDigits:MaxDigits];
    return numberFormatter;
}
@end
