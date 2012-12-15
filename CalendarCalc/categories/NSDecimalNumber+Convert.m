//
//  NSNumber+Convert.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/09.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "NSDecimalNumber+Convert.h"
#import "NSDecimalNumber+Calc.h"

@implementation NSDecimalNumber (Convert)
+ (NSDecimalNumber *)negate:(NSDecimalNumber *)number
{
    return [NSDecimalNumber multiplyingByDecimalNumber: number
                                              rOperand: [NSDecimalNumber decimalNumberWithString: @"-1"]];
}

NSDecimalNumber *DecimalNumber(NSString *const string)
{
    return [NSDecimalNumber decimalNumberWithString:string];
}
@end

