//
//  ASCEventManager.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "ASCEventManager.h"
#import "NSDate+Calc.h"
#import "NSDate+Style.h"
#import "EKEvent+Today.h"

@interface ASCEventManager ()
@property (strong, nonatomic, readwrite) NSArray *events;
@property (strong, nonatomic, readwrite) EKEvent *todayEvent;

- (void)reloadEvents;
- (NSArray *)pastEvents;
- (NSArray *)futureEvents;
- (NSArray *)distinctEvents:(NSArray *)events;
- (void)setupNotification;
@end

static const NSInteger EventIntervalYear = 2;

@implementation ASCEventManager
- (id)initWithDelegate:(id<ASCEventManagerDelegate>)delegate {
    if ((self = [super init])) {
        _delegate = delegate;
        
        _eventStore = [[EKEventStore alloc] init];
        if ([_eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
            [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                _granted = granted;
                [self reloadEvents];
                [self setupNotification];
            }];
        } else {
            _granted = YES;
            [self reloadEvents];
            [self setupNotification];
        }
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Private

- (void)reloadEvents
{
    self.events = nil;
    [self.delegate startEventLoad:self];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.todayEvent = [EKEvent todayEventWithEventStore:_eventStore];
        if (_granted) {
            NSMutableArray *events = [[NSMutableArray alloc] initWithArray:[self pastEvents]];
            [events addObject:self.todayEvent];
            [events addObjectsFromArray:[self futureEvents]];
            self.events = events;
        } else {
            self.events = @[self.todayEvent];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate completeEventLoad:self granted:_granted];
        });
    });
}

- (NSArray *)pastEvents
{
    NSDate *date = [[NSDate date] noTime];
    NSArray *events = [[_eventStore eventsMatchingPredicate:
                        [_eventStore predicateForEventsWithStartDate:[date addingByYear:-EventIntervalYear]
                                                             endDate:date
                                                           calendars:nil]]
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
    NSArray *events = [[_eventStore eventsMatchingPredicate:
                        [_eventStore predicateForEventsWithStartDate:date
                                                             endDate:[date addingByYear:EventIntervalYear]
                                                           calendars:nil]]
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
    if (_granted) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadEvents)
                                                     name:EKEventStoreChangedNotification
                                                   object:_eventStore];
    }
}

@end
