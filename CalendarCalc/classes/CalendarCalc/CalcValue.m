//
//  CalcValue.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/12.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcValue.h"
#import "CalcValueFormatter.h"
#import "NSArray+safe.h"
#import "NSDateFormatter+CalendarCalc.h"
#import "NSString+Locale.h"
#import "NSNumber+Predicate.h"

@interface CalcValue ()
@property(strong, nonatomic) NSMutableString *number;
@property(strong, nonatomic) NSMutableString *decimal;
@property(strong, nonatomic) NSDate *date;

- (NSString *)stringDecimalNumberValue;
@end

@implementation CalcValue
+ (CalcValue *)calcValueWithNumberString:(NSString *)number
                           decimalString:(NSString *)decimal
{
    CalcValue *result = [[CalcValue alloc] init];

    if (number) {
        [result setNumber:[NSMutableString stringWithString:number]];
    }
    if (decimal) {
        [result setDecimal:[NSMutableString stringWithString:decimal]];
    }
    
    return result;
}

+ (CalcValue *)calcValueWithDecimalNumber:(NSDecimalNumber *)decimalNumber
{
    NSArray *components = [[decimalNumber stringValue] componentsSeparatedByString:[NSString decimalSeparator]];
 
    return [self calcValueWithNumberString:[components safeObjectAtIndex:0]
                             decimalString:[components safeObjectAtIndex:1]];
}

+ (CalcValue *)calcValueWithDate:(NSDate *)date
{
    CalcValue *result = [[CalcValue alloc] init];
    [result setDate:date];
    
    return result;
}

- (NSString *)stringValue
{
    if ([self isNumber]) {
        return [CalcValueFormatter displayNumberWithCalcValue:self];
    } else {
        return [CalcValueFormatter displayDateWithCalcValue:self];
    }
}

- (NSDecimalNumber *)decimalNumberValue
{
    if (![self isNumber]) {
        return nil;
    }

    NSString *stringNumber = [self stringDecimalNumberValue];
    if (!stringNumber) {
        return nil;
    }

    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:stringNumber];
    if ([decimalNumber isNan]) {
        return [NSDecimalNumber zero];
    }
    return decimalNumber;

}

- (NSString *)stringNumberValue
{
    return self.number;
}

- (NSString *)stringDecimalValue
{
    return self.decimal;
}

- (NSDate *)dateValue
{
    return self.date;
}

- (void)inputNumberString:(NSString *)numberString
{
    self.date = nil;

    if (!self.number) {
        self.number = [NSMutableString string];
    }

    if (self.decimal) {
        [self.decimal appendString:numberString];
    } else {
        [self.number appendString:numberString];
    }
}

- (void)inputDate:(NSDate *)date
{
    self.number = nil;
    self.decimal = nil;

    self.date = date;
}

- (void)inputDecimalPoint
{
    if (![self isNumber]) {
        return;
    }

    if (!self.decimal) {
        self.decimal = [NSMutableString string];
    }
}

- (void)clear
{
    [self setNumber:nil];
    [self setDecimal:nil];
    [self setDate:nil];
}

- (void)deleteNumber
{
    if (![self isNumber]) {
        return;
    }

    if (self.decimal) {
        [self.decimal deleteCharactersInRange:NSMakeRange([self.decimal length] - 1, 1)];
    } else if (self.number) {
        [self.number deleteCharactersInRange:NSMakeRange([self.number length] - 1, 1)];
    }

    if ([self.decimal length] == 0) {
        self.decimal = nil;
    }
}

- (void)reverseNumber
{
    if (![self isNumber]) {
        return;
    }

    if (!self.number) {
        self.number = [NSMutableString string];
    }

    if ([self.number hasPrefix:@"-"]) {
        [self.number deleteCharactersInRange:NSMakeRange(0, 1)];
    } else {
        [self.number insertString:@"-" atIndex:0];
    }
}


#pragma makr - Private

- (BOOL)isNumber
{
    return !self.date;
}

- (NSString *)stringDecimalNumberValue
{
    NSMutableString *stringNumber = [NSMutableString string];
    if (self.number && [self.number length] > 0) {
        [stringNumber appendString:self.number];
    } else {
        [stringNumber appendString:@"0"];
    }

    if (self.decimal) {
        [stringNumber appendFormat:@"%@%@", [NSString decimalSeparator], self.decimal];
    }

    return stringNumber;
}
@end
