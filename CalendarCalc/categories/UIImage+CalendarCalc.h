//
//  UIImage+CalendarCalc.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/05.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CalendarCalc)
// Calculator
+ (UIImage *)numberKeyImage;
+ (UIImage *)operatorKeyImage;
+ (UIImage *)deleteKeyImage;
+ (UIImage *)plusMinusKeyImage;
+ (UIImage *)clearKeyImage;
+ (UIImage *)dateKeyImage;
+ (UIImage *)numberKeyImageWithOrientation:(UIInterfaceOrientation)orientation;
+ (UIImage *)operatorKeyImageWithOrientation:(UIInterfaceOrientation)orientation;
+ (UIImage *)clearKeyImageWithOrientation:(UIInterfaceOrientation)orientation;
+ (UIImage *)equalKeyImageWithOrientation:(UIInterfaceOrientation)orientation;

// Calendar
+ (UIImage *)calendarImageWithToday:(BOOL)isToday;
+ (UIImage *)todayImage;
+ (UIImage *)usualdayImage;
+ (UIImage *)calendarControllImage;
+ (UIImage *)prevImage;
+ (UIImage *)nextImage;
+ (UIImage *)dateSelectImage;

// SwitchButton
+ (UIImage *)stateOnImage;
+ (UIImage *)stateOffImage;
@end
