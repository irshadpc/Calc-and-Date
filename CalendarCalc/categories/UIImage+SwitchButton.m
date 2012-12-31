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
    static UIImage *stateOnImage = nil;
    if (!stateOnImage) {
        stateOnImage = [UIImage imageNamed:@"switch_button_on"];
    }
    return stateOnImage;
 }

+ (UIImage *)stateOffImage
{
    static UIImage *stateOffImage = nil;
    if (!stateOffImage) {
        stateOffImage = [UIImage imageNamed:@"switch_button_off"];
    }
    return stateOffImage;
}
@end
