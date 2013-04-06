//
//  UIImage+Calendar.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "UIImage+Calendar.h"

@implementation UIImage (Calendar)
+ (UIImage *)calendarImageWithToday:(BOOL)isToday
{
    if (isToday) {
        return [UIImage todayImage];
    } else {
        return [UIImage usualdayImage];
    }
}

+ (UIImage *)todayImage
{
    return [UIImage imageNamed:@"calendar_day_today"];
}

+ (UIImage *)usualdayImage
{
    return [UIImage imageNamed:@"calendar_day"];
}

+ (UIImage *)calendarControllImage
{
    return [UIImage imageNamed:@"calendar_controll_button"];
}

+ (UIImage *)prevImage
{
    return [UIImage imageNamed:@"prev"];
}

+ (UIImage *)nextImage
{
    return [UIImage imageNamed:@"next"];
}

+ (UIImage *)dateSelectImage
{
    return [UIImage imageNamed:@"date_select_button"];
}
@end
