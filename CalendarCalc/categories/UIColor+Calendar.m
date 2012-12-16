//
//  UIColor+Calendar.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/16.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "UIColor+Calendar.h"

@implementation UIColor (Calendar)

+ (UIColor *)sundayColor
{
    return [UIColor colorWithRed: 0.8
                           green: 0
                            blue: 0
                           alpha: 1];
}

+ (UIColor *)saturdayColor
{
    return [UIColor colorWithRed: 0
                           green: 0
                            blue: 0.8
                           alpha: 1];
}

+ (UIColor *)usualdayColor
{
    return [UIColor darkTextColor];
}

+ (UIColor *)otherMonthColor
{
    return [UIColor colorWithWhite: 0.6
                             alpha: 1];
}

@end
