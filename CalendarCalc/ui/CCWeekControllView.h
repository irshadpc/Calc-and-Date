//
//  CCWeekControllView.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCWeek.h"

@protocol CCWeekControllViewDelegate;
@class ASCCalendarView;

@interface CCWeekControllView : UIView
@property (weak, nonatomic) id <CCWeekControllViewDelegate> delegate;
- (id)initWithCalendarView:(ASCCalendarView *)calendarView;
@end

@protocol CCWeekControllViewDelegate <NSObject>

- (void)weekControllView:(CCWeekControllView *)view week:(ASCWeek)week on:(BOOL)on;

@end

