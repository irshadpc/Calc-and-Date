//
//  CalendarCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcTests.h"
#import "CalcController.h"
#import "CalcValue.h"
#import "CalcValueFormatter.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "NSDecimalNumber+Convert.h"

@interface CalendarCalcTests ()
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) CalcValueFormatter *formatter;
@end

@implementation CalendarCalcTests
- (void)setUp
{
    self.calcController = [[CalcController alloc] init];
    self.formatter = [[CalcValueFormatter alloc] initWithCalcController:self.calcController];
}

- (void)testCalendarCalc
{
    STAssertNotNil(self.calcController, @"CalendarCalc is nil");
}

- (void)testInputNumber_1
{
    [self.calcController inputInteger:1];
    NSString *const result = [self.formatter displayValue];
    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testInputNumber_12
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"12", result, @"RESULT: %@", result);
}

- (void)testInputNumber_12_Point_3
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:3];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"12.3", result, @"RESULT: %@", result);
}

- (void)testInputNumber_12_PlusMinus
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionPlusMinus];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"-12", result, @"RESULT: %@", result);
}

- (void)testInputDate_2012_12_15
{
    [self.calcController inputDate:[NSDate dateWithYear:2012
                                                  month:12
                                                    day:15]];
    NSString *const result = [self.formatter displayValue];
    STAssertEqualObjects(@"2012/12/15", result, @"RESULT: %@", result);
}

- (void)testinputInteger_20_Minus_30_Equal_PlusMinus_Minus_3_Equal
{
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionMinus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputInteger:FunctionPlusMinus];
    [self.calcController inputInteger:FunctionMinus];
    NSString *const result1 = [self.formatter displayValue];

    STAssertEqualObjects(@"10", result1, @"RESULT: %@", result1);

    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result2 = [self.formatter displayValue];

    STAssertEqualObjects(@"7", result2, @"RESULT: %@", result2);
}

- (void)testInputNumber_2_Multiply_00_Point_88_Equal
{
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionMultiply];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:8];
    [self.calcController inputInteger:8];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"0.176", result, @"RESULT: %@", result);
}

- (void)testInputNumber_4_Multiply_3_Equal_3_Multiply_2_Equal
{
    [self.calcController inputInteger:4];
    [self.calcController inputInteger:FunctionMultiply];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionMultiply];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"6", result, @"RESULT: %@", result);
}
@end
