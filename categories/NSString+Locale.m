//
//  NSString+Locale.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSString+Locale.h"

@implementation NSString (Locale)
+ (NSString *)decimalSeparator
{
    return [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
}

+ (NSString *)groupingSeparator
{
    return [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
}

+ (NSString *)dateSeparator
{
    return NSLocalizedString(@"SEPARATOR", nil);
}
@end
