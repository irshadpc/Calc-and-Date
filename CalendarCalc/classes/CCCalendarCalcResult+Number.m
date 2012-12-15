//
//  CCCalendarCalcResult+Number.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcResult+Number.h"
#import "NSString+Locale.h"
#import "NSNumberFormatter+CalendarCalc.h"

@interface CCCalendarCalcResult (NumberPrivate)
- (NSInteger)numberValue;
- (NSInteger)decimalValue;
- (BOOL)isDecimal;
@end


@implementation CCCalendarCalcResult (Number)

enum {
    Number,
    Decimal,
    DecimalCount
};

- (NSDecimalNumber *)numberResult
{
    if (![self isDecimal]) {
        return [NSDecimalNumber decimalNumberWithString:
                [NSString stringWithFormat: @"%d", _number]];
    } else {
        return [NSDecimalNumber decimalNumberWithString:
                [NSString stringWithFormat: @"%d%@%d", _number, [NSString decimalSeparator], _decimal]];
    }
}

- (CCCalendarCalcResult *)setNumberResult:(NSDecimalNumber *)number 
{
    NSArray *const componentsString = [[[NSNumberFormatter plainNumberFormatter] stringFromNumber:number]
                                       componentsSeparatedByString:[NSString decimalSeparator]];
    _number = [componentsString[Number] integerValue];
    if (componentsString.count == DecimalCount) {
        _decimal = [componentsString[Decimal] integerValue];
    }
     
    [_string setString:
     [[NSNumberFormatter displayNumberFormatter] stringFromNumber:number]];
    
    return self;
}

- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number
{
    [_string appendString:number.stringValue];
    if (!_isDecimal) {
        _number = [self numberValue];
    } else {
        _decimal = [self decimalValue];
    }
   
    return self;
}

- (CCCalendarCalcResult *)inputDecimalPoint
{
    [_string appendString:[NSString decimalSeparator]];
    _isDecimal = YES;

    return self;
}

- (CCCalendarCalcResult *)clearEntry
{
    NSString *const removedChar = [_string substringToIndex:_string.length - 1];
    if ([removedChar isEqualToString:[NSString decimalSeparator]]) {
        _isDecimal = NO;
    }
    [_string deleteCharactersInRange:NSMakeRange(_string.length - 2, 1)];
   
    return self;
}
@end


@implementation CCCalendarCalcResult (NumberPrivate)

- (NSInteger)numberValue
{
    return [[_string componentsSeparatedByString:[NSString decimalSeparator]][Number] integerValue];
}

- (NSInteger)decimalValue
{
    NSArray *const componentsString = [_string componentsSeparatedByString:[NSString decimalSeparator]];
    if (componentsString.count != DecimalCount) {
        return 0;
    }
    return [componentsString[Decimal] integerValue];
}

- (BOOL)isDecimal
{
    return _isDecimal && _decimal > 0;
}

@end