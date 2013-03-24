//
//  UIImage+Calendar.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Calendar)
+ (UIImage *)calendarImageWithToday:(BOOL)isToday;
+ (UIImage *)todayImage;
+ (UIImage *)usualdayImage;
+ (UIImage *)calendarControllImage;
+ (UIImage *)prevImage;
+ (UIImage *)nextImage;
+ (UIImage *)dateSelectImage;
@end
