//
//  CCAppDelegate+Setting.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/01.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Setting)
- (BOOL)includeStartDayOption;
- (void)setIncludeStartDayOption:(BOOL)isOn;

- (BOOL)dynamicCalendarOption;
- (void)setDynamicCalendarOption:(BOOL)isOn;
@end
