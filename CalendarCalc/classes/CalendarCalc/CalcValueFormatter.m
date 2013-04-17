//
//  CalcValueFormatter.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/17.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcValueFormatter.h"
#import "CalcValue.h"
#import "NSNumber+Predicate.h"
#import "NSNumberFormatter+CalendarCalc.h"
#import "NSString+Locale.h"

@implementation CalcValueFormatter
+ (NSString *)displayNumberWithCalcValue:(CalcValue *)calcValue
{
    NSDecimalNumber *number = nil;
    if ([calcValue stringNumberValue]) {
        number = [NSDecimalNumber decimalNumberWithString:[calcValue stringNumberValue]];
    } else {
        number = [NSDecimalNumber zero];
    }
    
    if ([number isNan]) {
        number = [NSDecimalNumber zero];
    }
    NSMutableString *numberString = [NSMutableString stringWithString:[[NSNumberFormatter displayLongNumberFormatter]
                                                                       stringFromNumber:number]];
    if ([calcValue stringDecimalValue]) {
        [numberString appendFormat:@"%@%@", [NSString decimalSeparator], [calcValue stringDecimalValue]];
    }
    return numberString;
}
@end
