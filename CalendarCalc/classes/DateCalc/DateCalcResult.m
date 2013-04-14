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
@end

@implementation DateCalcResult
- (CalcValue *)calcValue
{
    if (self.number) {
        return [CalcValue calcValueWithNumberString:self.number decimalString:nil];
    } else if (self.date) {
        return [CalcValue calcValueWithDate:self.date];
    } else {
        return nil;
    }
}

- (CalcValue *)inputNumberString:(NSString *)numberString
{
    if (!self.number) {
        self.number = [NSMutableString string];
    }

    [self setDate:nil];
    [self.number appendString:numberString];
    return [self calcValue];
}

- (CalcValue *)inputDate:(NSDate *)date
{
    [self setNumber:nil];
    [self setDate:date];
    return [self calcValue];
}

- (CalcValue *)inputDecimalPoint
{
    return [self calcValue];
}

- (CalcValue *)clear
{
    [self setNumber:nil];
    [self setDate:nil];
   
    return [self calcValue];
}

- (CalcValue *)deleteNumber
{
    if ([self.number length] > 0) {
        [self.number deleteCharactersInRange:NSMakeRange([self.number length] - 1, 1)];
    }
    [self setDate:nil];

    return [self calcValue];
}

- (CalcValue *)reverseNumber
{
    if ([self.number hasPrefix:@"-"]) {
        [self.number deleteCharactersInRange:NSMakeRange(0, 1)];
    } else {
        [self.number insertString:@"-" atIndex:0];
    }
    return [self calcValue];
}
@end
