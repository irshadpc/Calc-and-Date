//
//  UIButton+Border.m
//  CalendarCalc
//
//  Created by Junichi Ishida on 2013/09/20.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "UIButton+Border.h"

@implementation UIButton (Border)
- (void)setBorderColor:(UIColor *)color
{
    [self.layer setBorderWidth:0.25];
    [self.layer setBorderColor:[color CGColor]];
}
@end
