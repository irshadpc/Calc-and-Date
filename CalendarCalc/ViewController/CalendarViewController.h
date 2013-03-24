//
//  CCCalendarViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateSelect;
@class CalendarControllView;
@class WeekControllView;
@class PageView;
@class ViewSheet;

@interface CalendarViewController : UIViewController {
  @private
    NSArray *_calendarViews;
    CalendarControllView *_calendarControllView;
    WeekControllView *_weekControllView;
    PageView *_pageView;
    ViewSheet *_viewSheet;
    UIPopoverController *_popover;
}
@property (weak, nonatomic) id <DateSelect> delegate;
@property (nonatomic, readonly) UIButton *dateSelectButton;
@property (nonatomic, readonly) UIButton *prevButton;
@property (nonatomic, readonly) UIButton *nextButton;
@property (nonatomic, getter = isDynamicCalendar) BOOL dynamicCalendar;
@property (strong, nonatomic, readonly) NSDate *date;
@property (nonatomic, readonly) BOOL isPopoverVisible;

- (void)presentPopoverAnimated:(BOOL)animated;
- (void)dismissPopoverAnimated:(BOOL)animated;
@end
