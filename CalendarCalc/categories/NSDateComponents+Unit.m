//
//  NSDateComponents+Unit.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDateComponents+Unit.h"

@implementation NSDateComponents (Unit)

////////////////////////////////////////////////////////////////////////////////
+ (NSUInteger)componentsYMD
{
    return NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
}
@end
