//
//  UIImage+Calculator.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/01/05.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "UIImage+Calculator.h"

@interface UIImage (Caluculator_Private)
+ (UIImage *)imageWithOrientation:(UIInterfaceOrientation)orientation
                portraitImageName:(NSString *)portraitImageName
               landscapeImageName:(NSString *)landscapeImageName;
@end

@implementation UIImage (Calculator)
+ (UIImage *)numberKeyImage
{
    return [UIImage imageNamed:@"number_kay_flat"];
}

+ (UIImage *)operatorKeyImage
{
    return [UIImage imageNamed:@"operator_key_flat"];
}

+ (UIImage *)deleteKeyImage
{
    return [UIImage imageNamed:@"delete_key_flat"];
}

+ (UIImage *)plusMinusKeyImage
{
    return [UIImage imageNamed:@"plus_minus_key_flat"];
}

+ (UIImage *)clearKeyImage
{
    return [UIImage imageNamed:@"clear_key_flat"];
}

+ (UIImage *)dateKeyImage
{
    return [UIImage imageNamed:@"date_key_flat"];
}

+ (UIImage *)numberKeyImageWithOrientation:(UIInterfaceOrientation)orientation
{
    return [UIImage imageWithOrientation:orientation
                       portraitImageName:@"number_key"
                      landscapeImageName:@"number_key-Landscape"];
}

+ (UIImage *)operatorKeyImageWithOrientation:(UIInterfaceOrientation)orientation
{
    return [UIImage imageWithOrientation:orientation
                       portraitImageName:@"operator_key"
                      landscapeImageName:@"operator_key-Landscape"];
}

+(UIImage *)clearKeyImageWithOrientation:(UIInterfaceOrientation)orientation
{
    return [UIImage imageWithOrientation:orientation
                       portraitImageName:@"clear_key"
                      landscapeImageName:@"clear_key-Landscape"];
}

+ (UIImage *)equalKeyImageWithOrientation:(UIInterfaceOrientation)orientation
{
    return [UIImage imageWithOrientation:orientation
                       portraitImageName:@"equal_key"
                      landscapeImageName:@"equal_key-Landscape"];
}
@end


@implementation UIImage (Caluculator_Private)
+ (UIImage *)imageWithOrientation:(UIInterfaceOrientation)orientation
                portraitImageName:(NSString *)portraitImageName
               landscapeImageName:(NSString *)landscapeImageName
{
    return UIInterfaceOrientationIsPortrait(orientation) ? [UIImage imageNamed:portraitImageName]
                                                         : [UIImage imageNamed:landscapeImageName];
}
@end
