//
//  NSDateFormatter+CalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDateFormatter+CalendarCalc.h"
#import "NSString+Locale.h"

@implementation NSDateFormatter (CalendarCalc)
+ (NSDateFormatter *)yyyymmddFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:[NSString stringWithFormat:
                                  @"yyyy%@MM%@dd",
                                  [NSString dateSeparator],
                                  [NSString dateSeparator]]];

    [dateFormatter setCalendar:
     [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]];

    return dateFormatter;
}

- (BOOL)isDate:(NSString *)string
{
    if (!string || [string length] == 0) {
        return NO;
    }

    NSDate *date = nil;
    NSError *error = nil;
    NSRange range = NSMakeRange(0, [string length]);
    return [self getObjectValue:&date forString:string range:&range error:&error];
}
@end
