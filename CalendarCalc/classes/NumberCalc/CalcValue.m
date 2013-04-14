//
//  CalcValue.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/12.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcValue.h"
#import "NSArray+safe.h"
#import "NSDateFormatter+CalendarCalc.h"
#import "NSString+Locale.h"
#import "NSNumber+Predicate.h"

@interface CalcValue ()
@property(copy, nonatomic) NSString *number;
@property(copy, nonatomic) NSString *decimal;
@property(strong, nonatomic) NSDate *date;
@end

@implementation CalcValue
+ (CalcValue *)calcValueWithNumberString:(NSString *)number
                           decimalString:(NSString *)decimal
{
    CalcValue *result = [[CalcValue alloc] init];
    [result setNumber:number];
    [result setDecimal:decimal];
    
    return result;
}

+ (CalcValue *)calcValueWithDecimalNumber:(NSDecimalNumber *)decimalNumber
{
    CalcValue *result = [[CalcValue alloc] init];
    NSArray *components = [[decimalNumber stringValue] componentsSeparatedByString:[NSString decimalSeparator]];

    NSString *number = [components safeObjectAtIndex:0];
    if (number) {
        [result setNumber:number];
    }

    NSString *decimal = [components safeObjectAtIndex:1];
    if (decimal) {
        [result setDecimal:decimal];
    }

    return result;
}

+ (CalcValue *)calcValueWithDate:(NSDate *)date
{
    CalcValue *result = [[CalcValue alloc] init];
    [result setDate:date];
    
    return result;
}

- (BOOL)isNumber
{
    return ![self date];
}

- (NSString *)stringNumberValue
{
    if (!self.number && !self.decimal) {
        return nil;
    }

    NSMutableString *stringNumber = [NSMutableString string];
    if ([self.number length] > 0) {
        [stringNumber appendString:self.number];
    } else {
        [stringNumber appendString:@"0"];
    }

    if (self.decimal) {
        [stringNumber appendFormat:@"%@%@", [NSString decimalSeparator], self.decimal];
    }
    
    return stringNumber;
}

- (NSString *)stringDateValue
{
    return [[NSDateFormatter yyyymmddFormatter] stringFromDate:self.date];
}

- (NSDecimalNumber *)decimalNumberValue
{
    NSString *stringNumber = [self stringNumberValue];
    if (!stringNumber) {
        return nil;
    }

    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:stringNumber];
    if ([decimalNumber isNan]) {
        return [NSDecimalNumber zero];
    } else {
        return decimalNumber;
    }
}

- (NSDate *)dateValue
{
    return [self date];
}
@end
