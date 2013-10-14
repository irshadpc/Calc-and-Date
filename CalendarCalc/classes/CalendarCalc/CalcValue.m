//
//  CalcValue.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/12.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcValue.h"
#import "CalcControllerFormatter.h"
#import "NumberFormat.h"
#import "NSArray+Safe.h"
#import "NSDateFormatter+CalendarCalc.h"
#import "NSString+Locale.h"
#import "NSNumber+Predicate.h"
#import "NSNumberFormatter+CalendarCalc.h"

@interface CalcValue ()
@property(strong, nonatomic) NSMutableString *number;
@property(strong, nonatomic) NSMutableString *decimal;
@property(strong, nonatomic) NSDate *date;
@property(strong, nonatomic) NSNumberFormatter *numberFormatter;

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
    NSString *stringValue = [[NSNumberFormatter plainNumberFormatter] stringFromNumber:decimalNumber];
    NSArray *components = [stringValue componentsSeparatedByString:[NSString decimalSeparator]];

    return [self calcValueWithNumberString:[components safeObjectAtIndex:0]
                             decimalString:[components safeObjectAtIndex:1]];
}

+ (CalcValue *)calcValueWithDate:(NSDate *)date
{
    CalcValue *result = [[CalcValue alloc] init];
    [result setDate:date];
    
    return result;
}

- (instancetype)init
{
    if ((self = [super init])) {
        _numberFormatter = [NSNumberFormatter plainNumberFormatter];
    }
    return self;
}

- (BOOL)isNumber
{
    return !self.date;
}

- (BOOL)isCleared
{
    return !self.number && !self.decimal && !self.date;
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

    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:stringNumber
                                                                       locale:[NSLocale currentLocale]];
    if ([decimalNumber isNan]) {
        return [NSDecimalNumber zero];
    }
    return decimalNumber;
}

- (NSString *)stringNumberValue
{
    if (!self.number || [self.number length] == 0) {
        return @"0";
    }
    return [self.number stringByReplacingOccurrencesOfString:[NSString groupingSeparator]
                                                  withString:@""];
}

- (NSString *)stringDecimalValue
{
    if (self.decimal) {
        return [NSString stringWithFormat:@"%@%@", [NSString decimalSeparator], self.decimal];
    }
    return @"";
}

- (NSDate *)dateValue
{
    return self.date;
}

- (NSUInteger)decimalNumberLength
{
    return [[self.number stringByReplacingOccurrencesOfString:@"-" withString:@""] length] + [self.decimal length];
}

- (void)inputNumberString:(NSString *)numberString
{
    self.date = nil;

    if (!self.number) {
        self.number = [NSMutableString string];
    }

    while ([self decimalNumberLength] >= MaxDigits) {
        [self deleteNumber];
    }

    if (self.decimal) {
        [self.decimal appendString:numberString];
    } else {
        [self.number appendString:numberString];
    }

    while ([self decimalNumberLength] > MaxDigits) {
        [self deleteNumber];
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
   
    if ([self decimalNumberLength] >= MaxDigits) {
        return;
    }

    if (!self.decimal) {
        self.decimal = [NSMutableString string];
        if (!self.number) {
            self.number = [NSMutableString string];
        }
        if ([self.number length] == 0) {
            [self.number appendString:@"0"];
        }
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
        self.date = nil;
        return;
    }

    if ([self.decimal length] > 0) {
        [self.decimal deleteCharactersInRange:NSMakeRange([self.decimal length] - 1, 1)];
    } else if (self.decimal) {
        self.decimal = nil;
    } else if ([self.number length] > 0) {
        [self.number deleteCharactersInRange:NSMakeRange([self.number length] - 1, 1)];
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

- (NSString *)stringDecimalNumberValue
{
    return [NSString stringWithFormat:@"%@%@", [self stringNumberValue], [self stringDecimalValue]];
}
@end
