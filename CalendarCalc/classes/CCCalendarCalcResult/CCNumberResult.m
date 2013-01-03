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
#import "CCNumberFormat.h"

@interface CCNumberResult ()
- (void)innerClear;
- (void)innerClearEntry;
- (void)overFloor;
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

+ (NSDecimalNumber *)numberFromString:(NSString *)string
{
    NSNumber *number = [[NSNumberFormatter plainNumberFormatter] numberFromString:
                        [string stringByReplacingOccurrencesOfString:[NSString groupingSeparator] withString:@""]];
    if (!number) {
        return nil;
    }
    
    return ![number isNan] ? [NSDecimalNumber decimalNumberWithString:number.stringValue] : nil;
}

+ (NSString *)stringFromNumber:(NSDecimalNumber *)number
{
    NSInteger maxDigits = CCMaxDigits + ([number isMinus] ? 1 : 0);
    NSString *plainNumberString = [number.stringValue stringByReplacingOccurrencesOfString:
                                   [NSString decimalSeparator] withString:@""];
    if (plainNumberString.length <= maxDigits) {
        return [[NSNumberFormatter displayLongNumberFormatter] stringFromNumber:number];
    }
    
    NSArray *numberComponents = [[[NSNumberFormatter plainNumberFormatter] stringFromNumber:number]
                                 componentsSeparatedByString:[NSString decimalSeparator]];
    NSInteger numberLength = [numberComponents[Number] length] == 0 ? 1 : [numberComponents[Number] length];

    if (numberLength <= maxDigits - 2) {
        NSString *shortDecimal = nil;
        if (numberComponents.count == DecimalCount) {
            shortDecimal = [numberComponents[Decimal] substringToIndex:maxDigits - numberLength];
        } else  {
            shortDecimal = @"";
        }
        
        NSNumber *shortNumber = [[NSNumberFormatter plainNumberFormatter] numberFromString:
                                 [NSString stringWithFormat:@"%@%@%@",
                                  numberComponents[Number],
                                  [NSString decimalSeparator],
                                  shortDecimal]];
        
        return [[NSNumberFormatter displayLongNumberFormatter] stringFromNumber:shortNumber];
    } else {
        return [[NSNumberFormatter displayShortNumberFormatter] stringFromNumber:number];
    }
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
            [[NSNumberFormatter displayLongNumberFormatter] numberFromString:[self displayResult]].stringValue];
}

- (NSString *)displayResult
{
    NSMutableString *displayResult = [[NSMutableString alloc] init];

    if (_isMinus) {
        [displayResult appendString:@"-"];
    }

    if (_number.length > 0) {
        [displayResult appendString:
         [[NSNumberFormatter displayLongNumberFormatter] stringFromNumber:[NSDecimalNumber decimalNumberWithString:_number]]];
    } else {
        [displayResult appendString:[[NSNumberFormatter displayLongNumberFormatter] stringFromNumber:@0]];
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
    [self innerClearEntry];
    _isDecimal = _decimal.length > 0;
    _isClear = NO;
}

- (void)inputNumber:(NSDecimalNumber *)number
{
    [self innerClear];
    [self overFloor];
    
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
    [self innerClear];

    if (_number.length < CCMaxDigits) {
        _isDecimal = YES;
    }
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

- (void)innerClearEntry
{
    if (_isDecimal) {
        if (_decimal.length > 0) {
            [_decimal deleteCharactersInRange:NSMakeRange(_decimal.length - 1, 1)];
        }
    } else if (_number.integerValue != 0) {
        [_number deleteCharactersInRange:NSMakeRange(_number.length - 1, 1)];
        _isMinus = _number.length > 0 ? _isMinus : NO;
    }
}

- (void)overFloor
{
    NSInteger numberLength = _number.length == 0 ? 1 : _number.length;
    if (numberLength + _decimal.length < CCMaxDigits) {
        return;
    }
    [self innerClearEntry];
}

@end
