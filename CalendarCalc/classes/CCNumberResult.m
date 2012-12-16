//
//  CCNumberResult.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCNumberResult.h"
#import "NSString+Locale.h"
#import "NSNumber+Predicate.h"
#import "NSDecimalNumber+Convert.h"
#import "NSNumberFormatter+CalendarCalc.h"


@implementation CCNumberResult

enum {
    Number,
    Decimal,
    DecimalCount
};

- (id)init 
{
    if ((self = [super init])) {
        _number = [[NSMutableString alloc] init];
        _decimal = [[NSMutableString alloc] init];
        [_number setString:@"0"];
        _isPlus = YES;
    }
    return self;
}

- (void)clear
{
    [_number setString:@""];
    [_decimal setString:@""];
    _isDecimal = NO;
}

- (NSDecimalNumber *)result
{
    if (_number.length == 0 && _decimal.length == 0) {
        return nil;
    }
    
    return [NSDecimalNumber decimalNumberWithString:
            [[NSNumberFormatter displayNumberFormatter] numberFromString:[self displayResult]].stringValue];
}

- (NSString *)displayResult
{
    NSMutableString *displayResult = [[NSMutableString alloc] init];

    if (!_isPlus) {
        [displayResult appendString:@"-"];
    }

    [displayResult appendString:
     [[NSNumberFormatter displayNumberFormatter] stringFromNumber:[NSDecimalNumber decimalNumberWithString:_number]]];

    if (_isDecimal) {
        [displayResult appendString:[NSString decimalSeparator]];
        [displayResult appendString:_decimal];
    }
    
    return displayResult;
}

- (void)setResult:(NSDecimalNumber *)number
{
    NSArray *const componentsString = [[[NSNumberFormatter plainNumberFormatter] stringFromNumber:number]
                                       componentsSeparatedByString:[NSString decimalSeparator]];
    if (componentsString.count == DecimalCount) {
        _isDecimal = YES;
        [_decimal setString:componentsString[Decimal]];
    }
    [_number setString:componentsString[Number]];
    
    if ([number isMinus]) {
        _isPlus = NO;
        [_number deleteCharactersInRange:NSMakeRange(0, 1)];
    } else {
        _isPlus = YES;
    }
}

- (void)clearEntry
{
    if (_isDecimal) {
        [_decimal deleteCharactersInRange:NSMakeRange(_decimal.length - 1, 1)];
    } else if (_number.integerValue != 0) {
        [_number deleteCharactersInRange:NSMakeRange(_number.length - 1, 1)];
    }
   
    if (_decimal.length == 0) {
        _isDecimal = NO;
    }
}

- (void)inputNumber:(NSDecimalNumber *)number
{
    if (_isDecimal) {
        [_decimal appendString:number.stringValue];
    } else if (_number.integerValue != 0) {
        [_number appendString:number.stringValue];
    } else {
        [_number setString:number.stringValue];
    }
}

- (void)inputDecimalPoint
{
    _isDecimal = YES;
}

- (void)reverse 
{
    _isPlus = !_isPlus;
}

@end
