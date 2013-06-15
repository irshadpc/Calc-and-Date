//
//  CalcValueFormatter.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/17.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcControllerFormatter.h"
#import "CalcController.h"
#import "CalcValue.h"
#import "Function.h"
#import "NumberFormat.h"
#import "NSDateFormatter+CalendarCalc.h"
#import "NSDecimalNumber+Convert.h"
#import "NSNumber+Predicate.h"
#import "NSNumberFormatter+CalendarCalc.h"
#import "NSString+Locale.h"
#import "NSString+Calculator.h"
#import "NSString+Safe.h"

@interface CalcControllerFormatter ()
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) NSNumberFormatter *longNumberFormatter;
@property(strong, nonatomic) NSNumberFormatter *shortNumberFormatter;
@property(strong, nonatomic) NSNumberFormatter *plainNumberFormatter;
@property(strong, nonatomic) NSDateFormatter *yyyymmddFormatter;

- (NSString *)displayValueWithCalcValue:(CalcValue *)calcValue;
- (NSString *)displayNumberWithCalcValue:(CalcValue *)calcValue;
- (NSString *)displayDateWithCalcValue:(CalcValue *)calcValue;
- (NSString *)displayIndicatorValueWithFunction:(Function)function calcValue:(CalcValue *)calcValue;
- (NSNumberFormatter *)numberFormatterWithCalcValue:(CalcValue *)calcValue;
@end

@implementation CalcControllerFormatter
- (instancetype)initWithCalcController:(CalcController *)calcController
{
    if ((self = [super init])) {
        _calcController = calcController;
        _longNumberFormatter = [NSNumberFormatter longNumberFormatter];
        _shortNumberFormatter = [NSNumberFormatter shortNumberFormatter];
        _plainNumberFormatter = [NSNumberFormatter plainNumberFormatter];
        _yyyymmddFormatter = [NSDateFormatter yyyymmddFormatter];
    }
    return self;
}

- (NSString *)displayValue
{
    CalcValue *calcValue = [self.calcController result];
    if (!calcValue) {
        return @"0";
    }
    return [self displayValueWithCalcValue:calcValue];
}

- (NSString *)displayIndicatorValue
{
    if ([self.calcController function] == FunctionEqual || [self.calcController function] == FunctionNone) {
        return @"";
    }
    
    NSString *pendingIndicator = [self displayIndicatorValueWithFunction:[self.calcController pendingFunction]
                                                               calcValue:[self.calcController pendingValue]];
    NSString *mainIndicator = [self displayIndicatorValueWithFunction:[self.calcController function]
                                                            calcValue:[self.calcController operand]];
    if ([pendingIndicator length] > 0) {
        return [NSString stringWithFormat:@"%@(%@", pendingIndicator, mainIndicator];
    } else {
        return mainIndicator;
    }
}

- (NSString *)displayClearTitle
{
    return [self.calcController isAllCleared] ? @"AC" : @"C";
}


#pragma mark - Private

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
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[calcValue stringNumberValue]
                                                                locale:[NSLocale currentLocale]];
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
        return [numberFormatter stringFromNumber:[NSDecimalNumber decimalNumberWithString:decimalNumberString
                                                                                   locale:[NSLocale currentLocale]]];
    } else {
        return [NSString stringWithFormat:@"%@%@%@", sign, [numberFormatter stringFromNumber:number], decimalString];
    }
}

- (NSString *)displayDateWithCalcValue:(CalcValue *)calcValue
{
    return [self.yyyymmddFormatter stringFromDate:[calcValue dateValue]];
}

- (NSString *)displayIndicatorValueWithFunction:(Function)function calcValue:(CalcValue *)calcValue
{
    if (!calcValue) {
        return [NSString stringWithFunction:function];
    }
    return [NSString stringWithFormat:@"%@%@", [self displayValueWithCalcValue:calcValue],
                                               [NSString stringWithFunction:function]];
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
