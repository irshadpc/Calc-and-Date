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
#import "CalcValueFormatter.h"
#import "NSDecimalNumber+Convert.h"

@interface OldNumberCalcTests () {
  @private
    CalcController *_calcController;
}
@property(strong, nonatomic) CalcValueFormatter *formatter;
@end

@implementation OldNumberCalcTests

- (void)setUp
{
    _calcController = [[CalcController alloc] init];
    self.formatter = [[CalcValueFormatter alloc] init];
}

- (void)testinputInteger_1_Plus_2_Equal
{
    [_calcController inputInteger:  1];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  2];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
}

- (void)testinputInteger_2_Minus_1_Equal
{
    [_calcController inputInteger:  2];
    [_calcController inputInteger: FunctionMinus];
    [_calcController inputInteger:  1];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testinputInteger_2_Multiply_3_Equal
{
    [_calcController inputInteger:  2];
    [_calcController inputInteger: FunctionMultiply];
    [_calcController inputInteger:  3];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"6", result, @"RESULT: %@", result);
}

- (void)testinputInteger_6_Divide_2_Equal
{
    [_calcController inputInteger:  6];
    [_calcController inputInteger: FunctionDivide];
    [_calcController inputInteger:  2];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
}

- (void)testinputInteger_1_Plus_20_Equal
{
    [_calcController inputInteger:  1];
    [_calcController inputInteger: FunctionPlus];
    NSString *const result1 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger:  2]];
    
    STAssertEqualObjects(@"2", result1, @"RESULT1: %@", result1);
    
    [_calcController inputInteger:  0];
    NSString *const result2 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"21", result2, @"RESULT2: %@", result2);
}

- (void)testinputInteger_1_Plus_20_Minus_10_Equal
{
    [_calcController inputInteger:  1];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  2];
    [_calcController inputInteger:  0];
    NSString *const result1 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionMinus]];
    
    STAssertEqualObjects(@"21", result1, @"RESULT1: %@", result1);
    
    [_calcController inputInteger:  1];
    [_calcController inputInteger:  0];
    NSString *const result2 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"11", result2, @"RESULT2: %@", result2);
}

- (void)testinputInteger_3_Plus_Minus_2_Equal
{
    [_calcController inputInteger:  3];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger: FunctionMinus];
    [_calcController inputInteger:  2];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testinputInteger_3_Plus_1_Plus_Multiply_4_Equal
{
    [_calcController inputInteger:  3];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  1];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger: FunctionMultiply];
    [_calcController inputInteger:  4];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"16", result, @"RESULT: %@", result);
}

- (void)testinputInteger_12_Decimal_01_Plus_4_Equal
{
    [_calcController inputInteger:  1];
    [_calcController inputInteger:  2];
    [_calcController inputInteger: FunctionDecimal];
    [_calcController inputInteger:  0];
    NSString *const result1 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger:  1]];
    
    STAssertEqualObjects(@"12.01", result1, @"RESULT1: %@", result1);

    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  4];
    NSString *const result2 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"16.01", result2, @"RESULT: %@", result2);
}

- (void)testinputInteger_21_Plus_3_Equal_4_Plus_12_Equal
{
    [_calcController inputInteger:  2];
    [_calcController inputInteger:  1];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  3];
    [_calcController inputInteger: FunctionEqual];

    [_calcController inputInteger:  4];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  1];
    [_calcController inputInteger:  2];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"16", result, @"RESULT: %@", result);
}

- (void)testinputInteger_12_Plus_3_Equal_PlusMinus_Plus_9_Equal
{
    [_calcController inputInteger:  1];
    [_calcController inputInteger:  2];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  3];
    [_calcController inputInteger: FunctionEqual];
    NSString *const result1 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionPlusMinus]];
    
    STAssertEqualObjects(@"-15", result1, @"RESULT1: %@", result1);

    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  9];
    NSString *const result2 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"-6", result2, @"RESULT: %@", result2);
}

- (void)testinputInteger_10_Plus_30_Equal_Plus_10_Equal
{
    [_calcController inputInteger:  1];
    [_calcController inputInteger:  0];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  3];
    [_calcController inputInteger:  0];
    [_calcController inputInteger: FunctionEqual];
    NSString *const result1 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionPlus]];
    
    STAssertEqualObjects(@"40", result1, @"RESULT: %@", result1);
   
    [_calcController inputInteger:  1];
    [_calcController inputInteger:  0];
    NSString *const result2 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"50", result2, @"RESULT: %@", result2);
}

- (void)testinputInteger_12_Plus_3_Equal_Clear_Plus_3_Equal
{
    [_calcController inputInteger:  1];
    [_calcController inputInteger:  2];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  3];
    [_calcController inputInteger: FunctionEqual];
    [_calcController inputInteger: FunctionClear];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  3];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
}

- (void)testinputInteger_3_Plus_4_Equal_Decimal_2_Plus_1_Equal
{
    [_calcController inputInteger:  3];
    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  4];
    [_calcController inputInteger: FunctionEqual];
    [_calcController inputInteger: FunctionDecimal];
    NSString *const result1 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger:  2]];
    
    STAssertEqualObjects(@"0.2", result1, @"RESULT: %@", result1);

    [_calcController inputInteger: FunctionPlus];
    [_calcController inputInteger:  1];
    NSString *const result2 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: FunctionEqual]];
    
    STAssertEqualObjects(@"1.2", result2, @"RESULT: %@", result2);
}
@end
