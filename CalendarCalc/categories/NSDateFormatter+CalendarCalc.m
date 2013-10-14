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
    NSString *dateFormat = [NSString stringWithFormat:@"yyyy%@MM%@dd",
                                                      [NSString dateSeparator],
                                                      [NSString dateSeparator]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setCalendar:calendar];

    return dateFormatter;
}
@end
