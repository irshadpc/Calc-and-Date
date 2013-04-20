//
//  CalcValueFormatter.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/17.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcValueFormatter.h"
#import "CalcValue.h"
#import "NSDateFormatter+CalendarCalc.h"
#import "NSNumber+Predicate.h"
#import "NSNumberFormatter+CalendarCalc.h"

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
    
    NSString *formattedNumberString = [[NSNumberFormatter displayLongNumberFormatter] stringFromNumber:number];
    NSString *sign = isMinus ? @"-" : @"";
    return [NSString stringWithFormat:@"%@%@%@", sign, formattedNumberString, [calcValue stringDecimalValue]];
}

+ (NSString *)displayDateWithCalcValue:(CalcValue *)calcValue
{
    return [[NSDateFormatter yyyymmddFormatter] stringFromDate:[calcValue dateValue]];
}
@end
