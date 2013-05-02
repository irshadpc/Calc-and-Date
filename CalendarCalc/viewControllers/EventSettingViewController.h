//
//  CalendarSelectViewController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/29.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface EventSettingViewController : UIViewController
@property(strong, nonatomic) NSArray *disabledCalendars;
@property(nonatomic, getter=isEnabledEventColor) BOOL enabledEventColor;
@property(nonatomic, getter=isChanged, readonly) BOOL changed;
@end