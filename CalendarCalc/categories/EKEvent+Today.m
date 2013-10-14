//
//  EKEvent+Today.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "EKEvent+Today.h"
#import "NSDate+Component.h"

@implementation EKEvent (Today)
+ (EKEvent *)todayEventWithEventStore:(EKEventStore *)eventStore
{
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    
    NSDate *date = [[NSDate date] noTime];
    [event setTitle:NSLocalizedString(@"TODAY", nil)];
    [event setStartDate:date];
    [event setEndDate:date];
    return event;
}
@end
