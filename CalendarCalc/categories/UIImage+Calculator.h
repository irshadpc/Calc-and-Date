//
//  UIImage+Calculator.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/05.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Calculator)
+ (UIImage *)numberKeyImageWithOrientation:(UIInterfaceOrientation)orientation;
+ (UIImage *)operatorKeyImageWithOrientation:(UIInterfaceOrientation)orientation;
+ (UIImage *)clearKeyImageWithOrientation:(UIInterfaceOrientation)orientation;
+ (UIImage *)equalKeyImageWithOrientation:(UIInterfaceOrientation)orientation;
@end
