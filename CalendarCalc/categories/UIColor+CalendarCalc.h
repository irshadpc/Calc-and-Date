//
//  UIColor+CalendarCalc.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CalendarCalc)
// Calendar
+ (UIColor *)todayColor;
+ (UIColor *)sundayColor;
+ (UIColor *)saturdayColor;
+ (UIColor *)usualdayColor;
+ (UIColor *)otherMonthColor;

// SwitchButton
+ (UIColor *)titleColorForStateOn;
+ (UIColor *)titleColorForStateOff;
+ (UIColor *)titleShadowColorForStateOn;
+ (UIColor *)titleShadowColorForStateOff;
@end
