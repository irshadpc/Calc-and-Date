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
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIncludeStartDay];
}

- (void)setIncludeStartDayOption:(BOOL)isOn
{
    [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kIncludeStartDay];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)dynamicCalendarOption
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kDynamicCalendar];
}

- (void)setDynamicCalendarOption:(BOOL)isOn
{
    [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:kDynamicCalendar];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
