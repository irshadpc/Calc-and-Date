//
//  UIImage+Calculator.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/05.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "UIImage+Calculator.h"

@implementation UIImage (Calculator)

+ (UIImage *)numberKeyImageWithOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        static UIImage *portrateImage = nil;
        if (!portrateImage) {
            portrateImage = [UIImage imageNamed:@"number_key"];
        }
        return portrateImage;
    } else {
        static UIImage *landscapeImage = nil;
        if (!landscapeImage) {
            landscapeImage = [UIImage imageNamed:@"number_key-Landscape"];
        }
        return landscapeImage;
    }
}

+ (UIImage *)operatorKeyImageWithOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        static UIImage *portrateImage = nil;
        if (!portrateImage) {
            portrateImage = [UIImage imageNamed:@"operator_key"];
        }
        return portrateImage;
    } else {
        static UIImage *landscapeImage = nil;
        if (!landscapeImage) {
            landscapeImage = [UIImage imageNamed:@"operator_key-Landscape"];
        }
        return landscapeImage;
    }
}

+(UIImage *)clearKeyImageWithOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        static UIImage *portrateImage = nil;
        if (!portrateImage) {
            portrateImage = [UIImage imageNamed:@"clear_key"];
        }
        return portrateImage;
    } else {
        static UIImage *landscapeImage = nil;
        if (!landscapeImage) {
            landscapeImage = [UIImage imageNamed:@"clear_key-Landscape"];
        }
        return landscapeImage;
    }
}

+ (UIImage *)equalKeyImageWithOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        static UIImage *portrateImage = nil;
        if (!portrateImage) {
            portrateImage = [UIImage imageNamed:@"equal_key"];
        }
        return portrateImage;
    } else {
        static UIImage *landscapeImage = nil;
        if (!landscapeImage) {
            landscapeImage = [UIImage imageNamed:@"equal_key-Landscape"];
        }
        return landscapeImage;
    }
}

@end
