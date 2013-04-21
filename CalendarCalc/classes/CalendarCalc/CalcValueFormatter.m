//
//  CalcValueFormatter.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/17.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcValueFormatter.h"
#import "CalcValue.h"
#import "NumberFormat.h"
#import "NSDateFormatter+CalendarCalc.h"
#import "NSNumber+Predicate.h"
#import "NSNumberFormatter+CalendarCalc.h"
#import "NSString+Locale.h"
#import "NSString+Safe.h"


@implementation CalcValueFormatter
+ (NSString *)displayNumberWithCalcValue:(CalcValue *)calcValue
{
    NSMutableString *numberString = [NSMutableString stringWithString:[calcValue stringNumberValue]];
    BOOL isMinus = [numberString hasPrefix:@"-"];
    if (isMinus) {
        [numberString deleteCharactersInRange:NSMakeRange(0, 1)];
    }
     
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:numberString];
    if ([number isNan]) {
        number = [NSDecimalNumber zero];
    }
    
    NSNumberFormatter *numberFormatter = nil;
    if ([calcValue decimalNumberLength] <= MaxDigits) {
        numberFormatter = [NSNumberFormatter longNumberFormatter];
    } else if ([numberString length] > MaxNumberDigits) {
        numberFormatter = [NSNumberFormatter shortNumberFormatter];
    } else {
        numberFormatter = [NSNumberFormatter longNumberFormatter];
    }

    NSString *formattedNumberString = [numberFormatter stringFromNumber:number];
    NSUInteger decimalLength = MaxNumberDigits - [numberString length] + 3;
    NSString *decimalString = [[calcValue stringDecimalValue] safeSubstringToIndex:decimalLength];
    NSString *sign = isMinus ? @"-" : @"";
    return [NSString stringWithFormat:@"%@%@%@", sign, formattedNumberString, decimalString];
}

+ (NSString *)displayDateWithCalcValue:(CalcValue *)calcValue
{
    return [[NSDateFormatter yyyymmddFormatter] stringFromDate:[calcValue dateValue]];
}
@end
