//
//  NSNumberFormatter+CalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSNumberFormatter+CalendarCalc.h"

@implementation NSNumberFormatter (CalendarCalc)

+ (NSNumberFormatter *)displayNumberFormatter
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    return numberFormatter;
}

+ (NSNumberFormatter *)plainNumberFormatter
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterNoStyle];
    return numberFormatter;
}
@end
