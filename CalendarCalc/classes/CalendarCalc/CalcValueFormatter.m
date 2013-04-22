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
#import "NSDecimalNumber+Convert.h"
#import "NSNumber+Predicate.h"
#import "NSNumberFormatter+CalendarCalc.h"
#import "NSString+Locale.h"
#import "NSString+Safe.h"

@interface CalcValueFormatter ()
@property(strong, nonatomic) NSNumberFormatter *longNumberFormatter;
@property(strong, nonatomic) NSNumberFormatter *shortNumberFormatter;
@property(strong, nonatomic) NSNumberFormatter *plainNumberFormatter;
@property(strong, nonatomic) NSDateFormatter *yyyymmddFormatter;

- (NSString *)displayNumberWithCalcValue:(CalcValue *)calcValue;
- (NSString *)displayDateWithCalcValue:(CalcValue *)calcValue;
- (NSNumberFormatter *)numberFormatterWithCalcValue:(CalcValue *)calcValue;
@end

@implementation CalcValueFormatter
- (instancetype)init
{
    if ((self = [super init])) {
        _longNumberFormatter = [NSNumberFormatter longNumberFormatter];
        _shortNumberFormatter = [NSNumberFormatter shortNumberFormatter];
        _plainNumberFormatter = [NSNumberFormatter plainNumberFormatter];
        _yyyymmddFormatter = [NSDateFormatter yyyymmddFormatter];
    }
    return self;
}

- (NSString *)displayValueWithCalcValue:(CalcValue *)calcValue
{
    if ([calcValue isNumber]) {
        return [self displayNumberWithCalcValue:calcValue];
    } else {
        return [self displayDateWithCalcValue:calcValue];
    }
}

- (NSString *)displayNumberWithCalcValue:(CalcValue *)calcValue
{
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[calcValue stringNumberValue]];
    if ([number isNan]) {
        number = [NSDecimalNumber zero];
    }
    number = [NSDecimalNumber abs:number];

    NSNumberFormatter *numberFormatter = [self numberFormatterWithCalcValue:calcValue];
    NSUInteger decimalLength = MaxDigits - [[number stringValue] length] + 1;
    NSString *decimalString = [[calcValue stringDecimalValue] safeSubstringToIndex:decimalLength];
    NSString *sign = [[calcValue stringNumberValue] hasPrefix:@"-"] ? @"-" : @"";
    if ([calcValue decimalNumberLength] > MaxDigits) {
        NSString *numberString = [self.plainNumberFormatter stringFromNumber:number];
        NSString *decimalNumberString = [NSString stringWithFormat:@"%@%@%@", sign, numberString, decimalString];
        return [numberFormatter stringFromNumber:[NSDecimalNumber decimalNumberWithString:decimalNumberString]];
    } else {
        return [NSString stringWithFormat:@"%@%@%@", sign, [numberFormatter stringFromNumber:number], decimalString];
    }
}

- (NSString *)displayDateWithCalcValue:(CalcValue *)calcValue
{
    return [self.yyyymmddFormatter stringFromDate:[calcValue dateValue]];
}

- (NSNumberFormatter *)numberFormatterWithCalcValue:(CalcValue *)calcValue
{
    if ([calcValue decimalNumberLength] <= MaxDigits) {
        return self.longNumberFormatter;
    }
      
    if ([[calcValue stringNumberValue] length] > MaxNumberDigits) {
        return self.shortNumberFormatter;
    } else {
        return self.longNumberFormatter;
    }
}
@end
