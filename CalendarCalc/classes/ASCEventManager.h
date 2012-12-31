//
//  ASCEventManager.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface ASCEventManager : NSObject {
  @private
    EKEventStore *_eventStore;
    BOOL _granted;
}
@property (strong, nonatomic, readonly) NSArray *events;
@property (strong, nonatomic, readonly) EKEvent *todayEvent;
@property (nonatomic, readonly, getter = isEventLoaded) BOOL eventLoaded;

- (void)eventLoadWithCompletion:(void(^)(BOOL))completion;
@end
