//
//  ASCEventManager.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "EventManager.h"
#import "AppDelegate.h"
#import "AppDelegate+Setting.h"
#import "NSDate+Calc.h"
#import "NSDate+Component.h"
#import "EKEvent+Today.h"
#import "EKEventStore+Event.h"

@interface EventManager ()
@property(strong, nonatomic) EKEventStore *eventStore;
@property(strong, nonatomic) NSArray *calendars;
@property(strong, nonatomic, readwrite) NSArray *events;
@property(strong, nonatomic, readwrite) EKEvent *todayEvent;
@property(nonatomic, getter = isGranted) BOOL granted;

- (void)reloadEvents;
- (NSArray *)enabledCalendars;
- (NSArray *)pastEvents;
- (NSArray *)futureEvents;
- (NSArray *)distinctEvents:(NSArray *)events;
- (void)setupNotification;
@end

static const NSInteger EventIntervalYear = 2;

@implementation EventManager
- (id)initWithDelegate:(id<EventManagerDelegate>)delegate {
    if ((self = [super init])) {
        _delegate = delegate;
        
        _eventStore = [[EKEventStore alloc] init];
        [_eventStore requestAccessToEventWithCompletion:^(BOOL granted, NSError *error) {
            _granted = granted;
            [self reloadEvents];
            [self setupNotification];
        }];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadEvents
{
    [self.delegate startEventLoad:self];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.calendars = [self enabledCalendars];
        self.todayEvent = [EKEvent todayEventWithEventStore:self.eventStore];
        if (self.isGranted) {
            NSMutableArray *events = [[NSMutableArray alloc] initWithArray:[self pastEvents]];
            [events addObject:self.todayEvent];
            [events addObjectsFromArray:[self futureEvents]];
            self.events = events;
        } else {
            self.events = @[self.todayEvent];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate completeEventLoad:self granted:self.isGranted];
        });
    });
}


#pragma mark - Private

- (NSArray *)enabledCalendars
{
    NSMutableArray *calendars = [NSMutableArray array];
    NSArray *disabledCalendars = [(AppDelegate *)[[UIApplication sharedApplication] delegate] disabledCalendars];
    for (EKCalendar *calendar in [self.eventStore eventCalendars]) {
        if (![disabledCalendars containsObject:[calendar calendarIdentifier]]) {
            [calendars addObject:calendar];
        }
    }
    return calendars;
}

- (NSArray *)pastEvents
{
    NSDate *date = [[NSDate date] noTime];
    NSArray *events = [[self.eventStore eventsMatchingPredicate:
                        [self.eventStore predicateForEventsWithStartDate:[date addingByYear:-EventIntervalYear]
                                                             endDate:date
                                                           calendars:self.calendars]]
                       sortedArrayUsingComparator:^NSComparisonResult(EKEvent *l, EKEvent *r) {
                           NSComparisonResult result = [l.startDate compare:r.startDate];
                           if (result == NSOrderedAscending) {
                               return NSOrderedDescending;
                           } else if (result == NSOrderedDescending) {
                               return NSOrderedAscending;
                           } else {
                               return NSOrderedSame;
                           }
                       }];
    
    return [[self distinctEvents:events] sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
}

- (NSArray *)futureEvents
{
    NSDate *date = [[NSDate date] noTime];
    NSArray *events = [[self.eventStore eventsMatchingPredicate:
                        [self.eventStore predicateForEventsWithStartDate:date
                                                             endDate:[date addingByYear:EventIntervalYear]
                                                           calendars:self.calendars]]
                       sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];

    return [self distinctEvents:events];
}

- (NSArray *)distinctEvents:(NSArray *)events
{
    NSMutableArray *distinctIdentifier = [[NSMutableArray alloc] init];
    NSMutableArray *distinctEvents = [[NSMutableArray alloc] init];
    for (EKEvent *event in events) {
        if (event.eventIdentifier && ![distinctIdentifier containsObject:event.eventIdentifier]) {
            [distinctEvents addObject:event];
            [distinctIdentifier addObject:event.eventIdentifier];
        }
    }
    return distinctEvents;
}

- (void)setupNotification
{
    if (self.isGranted) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadEvents)
                                                     name:EKEventStoreChangedNotification
                                                   object:self.eventStore];
    }
}
@end
