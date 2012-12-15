//
//  CCNumberResult.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCNumberResult.h"
#import "NSString+Locale.h"
#import "NSNumberFormatter+CalendarCalc.h"

@interface CCNumberResult ()
- (NSInteger)numberValue;
- (NSInteger)decimalValue;
- (BOOL)isDecimal;
@end

@implementation CCNumberResult

enum {
    Number,
    Decimal,
    DecimalCount
};

- (id)init 
{
    if ((self = [super init])) {
        _string = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)clear
{
    _number = 0;
    _decimal = 0;
    _isDecimal = NO;
    [_string setString:@""];
}

- (NSDecimalNumber *)result
{
    if (![self isDecimal]) {
        return [NSDecimalNumber decimalNumberWithString:
                [NSString stringWithFormat: @"%d", _number]];
    } else {
        return [NSDecimalNumber decimalNumberWithString:
                [NSString stringWithFormat: @"%d%@%d", _number, [NSString decimalSeparator], _decimal]];
    }
}

- (void)setResult:(NSDecimalNumber *)number
{
    NSArray *const componentsString = [[[NSNumberFormatter plainNumberFormatter] stringFromNumber:number]
                                       componentsSeparatedByString:[NSString decimalSeparator]];
    _number = [componentsString[Number] integerValue];
    if (componentsString.count == DecimalCount) {
        _decimal = [componentsString[Decimal] integerValue];
    }


    [_string setString: [[NSNumberFormatter displayNumberFormatter] stringFromNumber:number]];
}

- (void)inputNumber:(NSDecimalNumber *)number
{
    [_string appendString:number.stringValue];
    if (!_isDecimal) {
        _number = [self numberValue];
    } else {
        _decimal = [self decimalValue];
    }
}

- (void)inputDecimalPoint
{
    [_string appendString:[NSString decimalSeparator]];
    _isDecimal = YES;
}

- (void)clearEntry
{
    NSString *const removedChar = [_string substringToIndex:_string.length - 1];
    if ([removedChar isEqualToString:[NSString decimalSeparator]]) {
        _isDecimal = NO;
    }
    [_string deleteCharactersInRange:NSMakeRange(_string.length - 2, 1)];
}

- (NSString *)displayResult
{
    return _string;
}

#pragma mark - Private

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
