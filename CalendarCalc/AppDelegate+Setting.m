//
//  CCAppDelegate+Setting.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "AppDelegate+Setting.h"
#import "UserDefaultsKeys.h"

@implementation AppDelegate (Setting)

- (BOOL)includeStartDayOption
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:IncludeStartDay];
}

- (void)setIncludeStartDayOption:(BOOL)includeStartDayOption
{
    [[NSUserDefaults standardUserDefaults] setBool:includeStartDayOption forKey:IncludeStartDay];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)dynamicCalendarOption
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:DynamicCalendar];
}

- (void)setDynamicCalendarOption:(BOOL)dynamicCalendarOption
{
    [[NSUserDefaults standardUserDefaults] setBool:dynamicCalendarOption forKey:DynamicCalendar];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)disabledCalendars
{
    return [[NSUserDefaults standardUserDefaults] stringArrayForKey:DisabledCalendars];
}

- (void)setDisabledCalendars:(NSArray *)disabledCalendars
{
    [[NSUserDefaults standardUserDefaults] setObject:disabledCalendars forKey:DisabledCalendars];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)eventColorOption
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:EventColor];
}

- (void)setEventColorOption:(BOOL)eventColorOption
{
    [[NSUserDefaults standardUserDefaults] setBool:eventColorOption forKey:EventColor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
