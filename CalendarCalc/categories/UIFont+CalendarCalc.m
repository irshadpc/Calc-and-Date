//
//  UIFont+CalendarCalc.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "UIFont+CalendarCalc.h"

@implementation UIFont (CalendarCalc)
+ (UIFont *)calendarFont
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [UIFont boldSystemFontOfSize:18.0];
    } else {
        return [UIFont boldSystemFontOfSize:26.0];
    }
}

+ (UIFont *)dateSelectFont
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [UIFont boldSystemFontOfSize:20.0];
    } else {
        return [UIFont boldSystemFontOfSize:30.0];
    }
}
@end
