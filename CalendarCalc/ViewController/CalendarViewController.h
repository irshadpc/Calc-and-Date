//
//  CCCalendarViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateSelect;
@protocol CalendarViewControllerDelegate;

@interface CalendarViewController : UIViewController
@property(weak, nonatomic) id<DateSelect> delegate;
@property(weak, nonatomic) id<CalendarViewControllerDelegate> actionDelegate;
@property(strong, nonatomic, readonly) NSDate *date;
@property(nonatomic, getter=isDynamicCalendar) BOOL dynamicCalendar;

- (BOOL)isPopoverVisible;
- (void)presentPopoverAnimated:(BOOL)animated;
- (void)dismissPopoverAnimated:(BOOL)animated;
- (UIButton *)dateSelectButton;
- (UIButton *)prevButton;
- (UIButton *)nextButton;
@end

@protocol CalendarViewControllerDelegate<NSObject>
- (void)calendarViewControllerDidCancel:(CalendarViewController *)calendarViewController;
- (void)calendarViewControllerShouldShowEvent:(CalendarViewController *)calendarViewController;
@end