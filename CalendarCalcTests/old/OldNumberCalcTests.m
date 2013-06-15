//
//  NumberCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "OldNumberCalcTests.h"
#import "CalcController.h"
#import "CalcValue.h"
#import "CalcControllerFormatter.h"
#import "NSDecimalNumber+Convert.h"

@interface OldNumberCalcTests ()
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) CalcControllerFormatter *formatter;
@end

@implementation OldNumberCalcTests

- (void)setUp
{
    self.calcController = [[CalcController alloc] init];
    self.formatter = [[CalcControllerFormatter alloc] initWithCalcController:self.calcController];
}

- (void)testinputInteger_1_Plus_2_Equal
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
}

- (void)testinputInteger_2_Minus_1_Equal
{
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionMinus];
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testinputInteger_2_Multiply_3_Equal
{
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionMultiply];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"6", result, @"RESULT: %@", result);
}

- (void)testinputInteger_6_Divide_2_Equal
{
    [self.calcController inputInteger:6];
    [self.calcController inputInteger:FunctionDivide];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
}

- (void)testinputInteger_1_Plus_20_Equal
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    NSString *const result1 = [self.formatter displayValue];

    STAssertEqualObjects(@"2", result1, @"RESULT1: %@", result1);

    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result2 = [self.formatter displayValue];

    STAssertEqualObjects(@"21", result2, @"RESULT2: %@", result2);
}

- (void)testinputInteger_1_Plus_20_Minus_10_Equal
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionMinus];
    NSString *const result1 = [self.formatter displayValue];

    STAssertEqualObjects(@"21", result1, @"RESULT1: %@", result1);

    [self.calcController inputInteger:1];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result2 = [self.formatter displayValue];

    STAssertEqualObjects(@"11", result2, @"RESULT2: %@", result2);
}

- (void)testinputInteger_3_Plus_Minus_2_Equal
{
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:FunctionMinus];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testinputInteger_3_Plus_1_Plus_Multiply_4_Equal
{
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:FunctionMultiply];
    [self.calcController inputInteger:4];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"16", result, @"RESULT: %@", result);
}

- (void)testinputInteger_12_Decimal_01_Plus_4_Equal
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:1];
    NSString *const result1 = [self.formatter displayValue];

    STAssertEqualObjects(@"12.01", result1, @"RESULT1: %@", result1);

    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:4];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result2 = [self.formatter displayValue];

    STAssertEqualObjects(@"16.01", result2, @"RESULT: %@", result2);
}

- (void)testinputInteger_21_Plus_3_Equal_4_Plus_12_Equal
{
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];

    [self.calcController inputInteger:4];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"16", result, @"RESULT: %@", result);
}

- (void)testinputInteger_12_Plus_3_Equal_PlusMinus_Plus_9_Equal
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputInteger:FunctionPlusMinus];
    NSString *const result1 = [self.formatter displayValue];

    STAssertEqualObjects(@"-15", result1, @"RESULT1: %@", result1);

    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:9];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result2 = [self.formatter displayValue];

    STAssertEqualObjects(@"-6", result2, @"RESULT: %@", result2);
}

- (void)testinputInteger_10_Plus_30_Equal_Plus_10_Equal
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputInteger:FunctionPlus];
    NSString *const result1 = [self.formatter displayValue];

    STAssertEqualObjects(@"40", result1, @"RESULT: %@", result1);

    [self.calcController inputInteger:1];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result2 = [self.formatter displayValue];

    STAssertEqualObjects(@"50", result2, @"RESULT: %@", result2);
}

- (void)testinputInteger_12_Plus_3_Equal_Clear_Plus_3_Equal
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputInteger:FunctionClear];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];

    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
}

- (void)testinputInteger_3_Plus_4_Equal_Decimal_2_Plus_1_Equal
{
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:4];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:2];
    NSString *const result1 = [self.formatter displayValue];

    STAssertEqualObjects(@"0.2", result1, @"RESULT: %@", result1);

    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result2 = [self.formatter displayValue];

    STAssertEqualObjects(@"1.2", result2, @"RESULT: %@", result2);
}
@end
