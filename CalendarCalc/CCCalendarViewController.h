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
@class ASCPageView;
@class CCViewSheet;

@interface CCCalendarViewController : UIViewController {
  @private
    NSArray *_calendarViews;
    ASCCalendarControllView *_calendarControllView;
    ASCPageView *_pageView;
    CCViewSheet *_viewSheet;
}
@property (weak, nonatomic) id <CCDateSelect> delegate;
@end
