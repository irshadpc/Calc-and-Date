//
//  NSString+Week.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSString+Week.h"
#import "ASCWeek.h"

@implementation NSString (Week)

+ (NSString *)stringWithWeek:(NSInteger)week
{
    switch (week) {
        case ASCSunday:
            return NSLocalizedString(@"SUN", nil);
        case ASCMonday:
            return NSLocalizedString(@"MON", nil);
        case ASCTuesday:
            return NSLocalizedString(@"TUE", nil);
        case ASCWednesday:
            return NSLocalizedString(@"WED", nil);
        case ASCThursday:
            return NSLocalizedString(@"THU", nil);
        case ASCFriday:
            return NSLocalizedString(@"FRI", nil);
        case ASCSaturday:
            return NSLocalizedString(@"SAT", nil);
        default:
            NSLog(@"WEEK: %d", week);
            abort();
    }
}
@end
