//
//  DateCalcResult.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/13.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "DateCalcResult.h"
#import "CalcValue.h"

@interface DateCalcResult ()
@property(strong, nonatomic) NSMutableString *number;
@property(strong, nonatomic) NSDate *date;

- (CalcValue *)result;
@end

@implementation DateCalcResult
- (CalcValue *)inputNumberString:(NSString *)numberString
{
    if (!self.number) {
        self.number = [NSMutableString string];
    }

    [self setDate:nil];
    [self.number appendString:numberString];
    return [self result];
}

- (CalcValue *)inputDate:(NSDate *)date
{
    [self setNumber:nil];
    [self setDate:date];
    return [self result];
}

- (CalcValue *)inputDecimalPoint
{
    return [self result];
}

- (CalcValue *)clear
{
    [self setNumber:nil];
    [self setDate:nil];
   
    return [self result];
}

- (CalcValue *)deleteNumber
{
    if ([self.number length] > 0) {
        [self.number deleteCharactersInRange:NSMakeRange([self.number length] - 1, 1)];
    }
    [self setDate:nil];

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
    if (self.number) {
        return [CalcValue calcValueWithNumberString:self.number decimalString:nil];
    } else if (self.date) {
        return [CalcValue calcValueWithDate:self.date];
    } else {
        return nil;
    }
}
@end
