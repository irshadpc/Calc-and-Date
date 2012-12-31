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
- (void)setupNotification;
@end

static const NSInteger EventIntervalYear = 2;

@implementation ASCEventManager
- (id)initWithDelegate:(id<ASCEventManagerDelegate>)delegate {
    if ((self = [super init])) {
        _delegate = delegate;
        
        _eventStore = [[EKEventStore alloc] init];
        _todayEvent = [EKEvent todayEventWithEventStore:_eventStore];
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
        if (_granted) {
            NSMutableArray *distinctEvents = [NSMutableArray arrayWithObject:self.todayEvent];
            NSDate *date = [NSDate date];
            NSArray *events = [_eventStore eventsMatchingPredicate:
                               [_eventStore predicateForEventsWithStartDate:[[date addingByYear:-EventIntervalYear] noTime]
                                                                    endDate:[[date addingByYear:EventIntervalYear] noTime]
                                                                  calendars:nil]];
            for (EKEvent *event in events) {
                NSPredicate *containPredicate = [NSPredicate predicateWithFormat:@"eventIdentifier = %@", event.eventIdentifier];

                if ([[distinctEvents filteredArrayUsingPredicate:containPredicate] count] == 0) {
                    [distinctEvents addObject:event];
                }
            }

            self.events = [distinctEvents sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
        } else {
            self.events = @[self.todayEvent];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate completeEventLoad:self granted:_granted];
        });
    });
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
