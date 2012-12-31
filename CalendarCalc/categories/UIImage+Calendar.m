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
    static UIImage *calendarImage = nil;
    if (!calendarImage) {
        calendarImage = [UIImage imageNamed:@"calendar_day"];
    }
    return calendarImage;
}
@end
