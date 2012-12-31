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
@property (nonatomic, readwrite) BOOL eventLoaded;

- (void)reloadEvents;
@end

static const NSInteger EventIntervalYear = 2;

@implementation ASCEventManager
- (id)init {
    if ((self = [super init])) {
        _eventStore = [[EKEventStore alloc] init];
    }
    return self;
}

- (void)eventLoadWithCompletion:(void (^)(BOOL))completion
{
    if ([_eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {             
            _granted = granted;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self reloadEvents];
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(granted);
                });
            });
        }];
    } else {
        _granted = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self reloadEvents];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(YES);
            });
        });
    }
}


#pragma mark - Private

- (void)reloadEvents
{
    if (!_granted) {
        return;
    }

    self.todayEvent = [EKEvent todayEventWithEventStore:_eventStore];
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

    self.eventLoaded = YES;
    self.events = [distinctEvents sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
}

@end
