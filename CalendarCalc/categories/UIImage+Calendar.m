//
//  UIImage+Calendar.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "UIImage+Calendar.h"

@implementation UIImage (Calendar)
+ (UIImage *)calendarImage
{
    static UIImage *image = nil;
    if (!image) {
        image = [UIImage imageNamed:@"calendar_day"];
    }
    return image;
}

+ (UIImage *)calendarImageForSunday
{
    static UIImage *image = nil;
    if (!image) {
        image = [UIImage imageNamed:@"calendar_day_sun"];
    }
    return image;
}

+ (UIImage *)calendarImageForSaturday
{
    static UIImage *image = nil;
    if (!image) {
        image = [UIImage imageNamed:@"calendar_day_sat"];
    }
    return image;
}

+ (UIImage *)dateSelectImage
{
    static UIImage *image = nil;
    if (!image) {
        image = [UIImage imageNamed:@"date_select_button"];
    }
    return image;
}

+ (UIImage *)calendarControllImage
{
    static UIImage *image = nil;
    if (!image) {
        image = [UIImage imageNamed:@"calendar_controll_button"];
    }
    return image;
}

+ (UIImage *)prevImage
{
    static UIImage *image = nil;
    if (!image) {
        image = [UIImage imageNamed:@"prev"];
    }
    return image;
}

+ (UIImage *)nextImage
{
    static UIImage *image = nil;
    if (!image) {
        image = [UIImage imageNamed:@"next"];
    }
    return image;
}

@end
