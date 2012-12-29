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

@interface CCNumberResult ()
- (void)innerClear;
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
        _number = [[NSMutableString alloc] init];
        _decimal = [[NSMutableString alloc] init];
        [_number setString:@"0"];
    }
    return self;
}

- (void)clear
{
    _isClear = YES;
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

    if (_isMinus) {
        [displayResult appendString:@"-"];
    }

    if (_number.length > 0) {
        [displayResult appendString:
         [[NSNumberFormatter displayNumberFormatter] stringFromNumber:[NSDecimalNumber decimalNumberWithString:_number]]];
    } else {
        [displayResult appendString:[[NSNumberFormatter displayNumberFormatter] stringFromNumber:@0]];
    }

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

    [_number setString:componentsString[Number]];
    
    _isMinus = [number isMinus];
    if (_isMinus) {
        [_number deleteCharactersInRange:NSMakeRange(0, 1)];
    }

    _isDecimal = componentsString.count == DecimalCount;
    if (_isDecimal) {
        [_decimal setString:componentsString[Decimal]];
    }
}

- (void)clearEntry
{
    if (_isDecimal) {
        [_decimal deleteCharactersInRange:NSMakeRange(_decimal.length - 1, 1)];
        _isDecimal = _decimal.length > 0;
    } else if (_number.integerValue != 0) {
        [_number deleteCharactersInRange:NSMakeRange(_number.length - 1, 1)];
        _isMinus = _number.length > 0 ? _isMinus : NO;
    }
}

- (void)inputNumber:(NSDecimalNumber *)number
{
    [self innerClear];
    if (_isDecimal) {
        NSLog(@"DECIMAL: %@", _decimal);
        [_decimal appendString:number.stringValue];
    } else if (_number.integerValue != 0) {
        [_number appendString:number.stringValue];
    } else {
        [_number setString:number.stringValue];
    }
}

- (void)inputDecimalPoint
{
    [self innerClear];
    _isDecimal = YES;
}

- (void)reverse 
{
    _isMinus = !_isMinus;
}


#pragma mark - Private

- (void)innerClear
{
    if (_isClear) {
        [_number setString:@""];
        [_decimal setString:@""];
        _isDecimal = NO;
        _isMinus = NO;
        _isClear = NO;
    }
}

@end
