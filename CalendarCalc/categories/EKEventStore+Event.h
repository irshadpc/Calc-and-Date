//
//  EKEventStore+Event.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/05/08.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <EventKit/EventKit.h>

@interface EKEventStore (Event)
- (void)requestAccessToEventWithCompletion:(EKEventStoreRequestAccessCompletionHandler)completion;
- (NSArray *)eventCalendars;
@end
