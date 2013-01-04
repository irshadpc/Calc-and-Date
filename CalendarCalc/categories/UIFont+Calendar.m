//
//  UIFont+Calendar.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "UIFont+Calendar.h"

@implementation UIFont (Calendar)
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
        return [UIFont boldSystemFontOfSize:18.0];
    } else {
        return [UIFont boldSystemFontOfSize:30.0];
    }
}
@end
