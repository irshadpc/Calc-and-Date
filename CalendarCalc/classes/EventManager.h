//
//  ASCEventManager.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@protocol EventManagerDelegate;

@interface EventManager : NSObject
@property(weak, nonatomic) id <EventManagerDelegate> delegate;
@property(strong, nonatomic, readonly) NSArray *events;
@property(strong, nonatomic, readonly) EKEvent *todayEvent;

- (id)initWithDelegate:(id<EventManagerDelegate>)delegate;
- (void)reloadEvents;
@end

@protocol EventManagerDelegate<NSObject>
- (void)startEventLoad:(EventManager *)eventManager;
- (void)completeEventLoad:(EventManager *)eventManager granted:(BOOL)granted;
@end