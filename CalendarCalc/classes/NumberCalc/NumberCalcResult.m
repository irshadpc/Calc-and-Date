//
//  NumberCalcResult.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/11.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NumberCalcResult.h"
#import "CalcValue.h"

@interface NumberCalcResult ()
@property(strong, nonatomic) NSMutableString *number;
@property(strong, nonatomic) NSMutableString *decimal;

- (CalcValue *)result;
@end

@implementation NumberCalcResult
- (instancetype)init
{
    if ((self = [super init])) {
        _number = [NSMutableString string];
    }
    return self;
}

- (NSDecimalNumber *)decimalNumberValue
{
    return [[self result] decimalNumberValue];
}

- (CalcValue *)inputNumberString:(NSString *)numberString
{
    if (self.decimal) {
        [self.decimal appendString:numberString];
    } else {
        [self.number appendString:numberString];
    }

    return [self result];
}

- (CalcValue *)inputDecimalPoint
{
    if (!self.decimal) {
        self.decimal = [NSMutableString string];
    }
    
    return [self result];
}

- (CalcValue *)clear
{
    [self setNumber:[NSMutableString string]];
    [self setDecimal:nil];

    return [self result];
}

- (CalcValue *)deleteNumber
{
    if (self.decimal) {
        [self.decimal deleteCharactersInRange:NSMakeRange([self.decimal length] - 1, 1)];
    } else {
        [self.number deleteCharactersInRange:NSMakeRange([self.number length] - 1, 1)];
    }

    if ([self.decimal length] == 0) {
        self.decimal = nil;
    }
   
    return [self result];
}

- (CalcValue *)reverseNumber
{
    if ([self.number hasPrefix:@"-"]) {
        [self.number deleteCharactersInRange:NSMakeRange(0, 1)];
    } else {
        [self.number insertString:@"-" atIndex:0];
    }
    return [self result];
}


#pragma mark - Private

- (CalcValue *)result
{
    return [CalcValue calcValueWithNumberString:self.number decimalString:self.decimal];
}
@end
