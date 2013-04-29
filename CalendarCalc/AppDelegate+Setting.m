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

- (void)setIncludeStartDayOption:(BOOL)isOn
{
    [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:IncludeStartDay];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)dynamicCalendarOption
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:DynamicCalendar];
}

- (void)setDynamicCalendarOption:(BOOL)isOn
{
    [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:DynamicCalendar];
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
@end
