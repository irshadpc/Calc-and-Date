//
//  NSString+Date.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/19.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)
+ (NSString *)stringWithYear:(NSInteger)year 
                       month:(NSInteger)month
{
    return [NSString stringWithFormat:@"%d%@%02d", year, NSLocalizedString(@"SEPARATOR", nil), month];
}

@end
