//
//  CalendarSelectViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/29.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@protocol CalendarSelectViewControllerDelegate;

@interface CalendarSelectViewController : UIViewController
@property(weak, nonatomic) id<CalendarSelectViewControllerDelegate> delegate;
@end

@protocol CalendarSelectViewControllerDelegate<NSObject>
- (void)calendarSelectViewControllerDidFinish:(CalendarSelectViewController *)calendarSelectViewController;
@end