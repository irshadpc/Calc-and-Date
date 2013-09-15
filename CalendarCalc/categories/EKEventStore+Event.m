//
//  EKEventStore+Event.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/05/08.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "EKEventStore+Event.h"

@implementation EKEventStore (Event)
- (void)requestAccessToEventWithCompletion:(EKEventStoreRequestAccessCompletionHandler)completion
{
    if ([self respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [self requestAccessToEntityType:EKEntityTypeEvent
                             completion:^(BOOL granted, NSError *error) {
                                 completion(granted, error);
                             }];
    } else {
        completion(YES, nil);
    }
}

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
- (NSArray *)eventCalendars
{
    if ([self respondsToSelector:@selector(calendarsForEntityType:)]) {
        return [self calendarsForEntityType:EKEntityTypeEvent];
    } else {
        return [self calendars];
    }
}
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
@end
