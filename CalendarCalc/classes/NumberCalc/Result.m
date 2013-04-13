//
//  Result.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/12.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "Result.h"
#import "NSArray+safe.h"
#import "NSString+Locale.h"
#import "NSNumber+Predicate.h"

@interface Result ()
@property(copy, nonatomic) NSString *number;
@property(copy, nonatomic) NSString *decimal;
@end

@implementation Result
+ (Result *)resultWithNumberString:(NSString *)number
                     decimalString:(NSString *)decimal
{
    Result *result = [[Result alloc] init];
    [result setNumber:number];
    [result setDecimal:decimal];
    
    return result;
}

+ (Result *)resultWithDecimalNumber:(NSDecimalNumber *)decimalNumber
{
    Result *result = [[Result alloc] init];
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
@end
