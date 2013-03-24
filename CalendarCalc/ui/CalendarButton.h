//
//  CalendarButton.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/22.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Week.h"

@interface CalendarButton : UIButton
@property(nonatomic) NSInteger dayOfCalendar;
@property(nonatomic) NSInteger year;
@property(nonatomic) NSInteger month;
@property(nonatomic) NSInteger dayOfMonth;
@property(nonatomic) Week weekday;
@property(nonatomic, getter=isOtherMonthDate) BOOL otherMonthDate;
@property(nonatomic, getter=isToday) BOOL today;
@property(nonatomic) BOOL hasEvent;
@property(nonatomic, getter=isOn) BOOL on;
@end