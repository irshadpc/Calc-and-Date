//
//  ASCEventManager.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@protocol ASCEventManagerDelegate;

@interface ASCEventManager : NSObject {
  @private
    BOOL _granted;
    EKEventStore *_eventStore;
}
@property (weak, nonatomic) id <ASCEventManagerDelegate> delegate;
@property (strong, nonatomic, readonly) NSArray *events;
@property (strong, nonatomic, readonly) EKEvent *todayEvent;

- (id)initWithDelegate:(id <ASCEventManagerDelegate>)delegate;
@end

@protocol ASCEventManagerDelegate <NSObject>
- (void)startEventLoad:(ASCEventManager *)eventManager;
- (void)completeEventLoad:(ASCEventManager *)eventManager granted:(BOOL)granted;
@end