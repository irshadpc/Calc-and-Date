//
//  NSNumberFormatter+CalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSNumberFormatter+CalendarCalc.h"
#import "CCNumberFormat.h"

@implementation NSNumberFormatter (CalendarCalc)

+ (NSNumberFormatter *)displayLongNumberFormatter
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:CCMaxDigits];
    return numberFormatter;
}

+ (NSNumberFormatter *)displayShortNumberFormatter
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    [numberFormatter setMaximumFractionDigits:CCMaxDigits];
    return numberFormatter;
}

+ (NSNumberFormatter *)plainNumberFormatter
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterNoStyle];
    [numberFormatter setMaximumFractionDigits:CCMaxDigits];
    return numberFormatter;
}
@end
