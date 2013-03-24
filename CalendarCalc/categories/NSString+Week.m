//
//  NSString+Week.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSString+Week.h"
#import "Week.h"

@implementation NSString (Week)

+ (NSString *)stringWithWeek:(NSInteger)week
{
    switch (week) {
        case Sunday:
            return NSLocalizedString(@"SUN", nil);
        case Monday:
            return NSLocalizedString(@"MON", nil);
        case Tuesday:
            return NSLocalizedString(@"TUE", nil);
        case Wednesday:
            return NSLocalizedString(@"WED", nil);
        case Thursday:
            return NSLocalizedString(@"THU", nil);
        case Friday:
            return NSLocalizedString(@"FRI", nil);
        case Saturday:
            return NSLocalizedString(@"SAT", nil);
        default:
            NSLog(@"WEEK: %d", week);
            abort();
    }
}
@end
