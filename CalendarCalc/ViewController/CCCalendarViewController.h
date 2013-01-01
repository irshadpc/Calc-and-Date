//
//  CCCalendarViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/23.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCDateSelect;
@class ASCCalendarControllView;
@class CCWeekControllView;
@class ASCPageView;
@class CCViewSheet;

@interface CCCalendarViewController : UIViewController {
  @private
    NSArray *_calendarViews;
    ASCCalendarControllView *_calendarControllView;
    CCWeekControllView *_weekControllView;
    ASCPageView *_pageView;
    CCViewSheet *_viewSheet;
}
@property (weak, nonatomic) id <CCDateSelect> delegate;
@property (nonatomic, getter = isDynamicCalendar) BOOL dynamicCalendar;
@end
