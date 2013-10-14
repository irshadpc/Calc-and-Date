//
//  UIColor+CalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "UIColor+CalendarCalc.h"

@implementation UIColor (CalendarCalc)

#pragma mark - Calendar

+ (UIColor *)todayColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)sundayColor
{
    return [UIColor colorWithRed:0.8
                           green:0
                            blue:0
                           alpha:1];
}

+ (UIColor *)saturdayColor
{
    return [UIColor colorWithRed:0
                           green:0
                            blue:0.8
                           alpha:1];
}

+ (UIColor *)usualdayColor
{
    return [UIColor darkTextColor];
}

+ (UIColor *)otherMonthColor
{
    return [UIColor colorWithWhite:0.6
                             alpha:1];
}


#pragma mark - SwitchButton

+ (UIColor *)titleColorForStateOn
{
    return [UIColor whiteColor];
}

+ (UIColor *)titleColorForStateOff
{
    return [UIColor lightGrayColor];
}

+ (UIColor *)titleShadowColorForStateOn
{
    return [UIColor lightGrayColor];
}

+ (UIColor *)titleShadowColorForStateOff
{
    return [UIColor whiteColor];
}
@end
