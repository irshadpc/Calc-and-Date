//
//  NSDateFormatter+CalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDateFormatter+CalendarCalc.h"

@implementation NSDateFormatter (CalendarCalc)
+ (NSDateFormatter *)yyyymmddFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: [NSString stringWithFormat:
                                   @"yyyy%@MM%@dd",
                                   @"/",
                                   @"/"]];

    [dateFormatter setCalendar:
     [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar]];

    return dateFormatter;
}
@end
