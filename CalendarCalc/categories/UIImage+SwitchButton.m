//
//  UIImage+SwitchButton.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/31.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "UIImage+SwitchButton.h"

@implementation UIImage (SwitchButton)
+ (UIImage *)stateOnImage
{
    return [UIImage imageNamed:@"switch_button_on"];
}

+ (UIImage *)stateOffImage
{
    return [UIImage imageNamed:@"switch_button_off"];
}
@end
