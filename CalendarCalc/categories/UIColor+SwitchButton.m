//
//  UIColor+SwitchButton.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "UIColor+SwitchButton.h"

@implementation UIColor (SwitchButton)
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
