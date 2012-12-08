//
//  NSDate+Component.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDate+Component.h"

@implementation NSDate (Component)

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components: NSWeekdayCalendarUnit
                                            fromDate: self]
            weekday];
}

@end
