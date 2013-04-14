//
//  NumberCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/13.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NumberCalcTests.h"
#import "NumberCalc.h"
#import "CalcValue.h"
#import "Function.h"

@interface NumberCalcTests ()
@property(strong, nonatomic) NumberCalc *numberCalc;
@end

@implementation NumberCalcTests
- (void)setUp
{
    self.numberCalc = [[NumberCalc alloc] init];
}


#pragma mark - input

- (void)test_123
{
    [self.numberCalc input:1];
    [self.numberCalc input:2];
    CalcValue *result = [self.numberCalc input:3];

    STAssertEqualObjects(@"123", [result stringNumberValue], nil);
}

- (void)test_12_Decimal_3
{
    [self.numberCalc input:1];
    [self.numberCalc input:2];
    [self.numberCalc input:FunctionDecimal];
    CalcValue *result =[self.numberCalc input:3];

    STAssertEqualObjects(@"12.3", [result stringNumberValue], nil);
}

- (void)test_Decimal_3
{
    [self.numberCalc input:FunctionDecimal];
    CalcValue *result = [self.numberCalc input:3];

    STAssertEqualObjects(@"0.3", [result stringNumberValue], nil);
}

- (void)test_Decimal
{
    CalcValue *result = [self.numberCalc input:FunctionDecimal];

    STAssertEqualObjects(@"0.", [result stringNumberValue], nil);
}


#pragma mark - Calc

- (void)test_1_Plus_2_Equal_3
{
    [self.numberCalc input:1];
    [self.numberCalc input:FunctionPlus];
    [self.numberCalc input:2];
    CalcValue *result = [self.numberCalc input:FunctionEqual];
   
    STAssertEqualObjects(@"3", [result stringNumberValue], nil);
}

- (void)test_1_Minus_2_Equal_Minus1
{
    [self.numberCalc input:1];
    [self.numberCalc input:FunctionMinus];
    [self.numberCalc input:2];
    CalcValue *result = [self.numberCalc input:FunctionEqual];

    STAssertEqualObjects(@"-1", [result stringNumberValue], nil);
}

- (void)test_2_Multi_3_Equal_6
{
    [self.numberCalc input:2];
    [self.numberCalc input:FunctionMultiply];
    [self.numberCalc input:3];
    CalcValue *result = [self.numberCalc input:FunctionEqual];

    STAssertEqualObjects(@"6", [result stringNumberValue], nil);
}

- (void)test_6_Div_2_Equal_3
{
    [self.numberCalc input:6];
    [self.numberCalc input:FunctionDivide];
    [self.numberCalc input:2];
    CalcValue *result = [self.numberCalc input:FunctionEqual];

    STAssertEqualObjects(@"3", [result stringNumberValue], nil);
}

- (void)test_1_Plus_2_Plus_3_Equal_6
{
    [self.numberCalc input:1];
    [self.numberCalc input:FunctionPlus];
    [self.numberCalc input:2];
    [self.numberCalc input:FunctionPlus];
    [self.numberCalc input:3];
    CalcValue *result = [self.numberCalc input:FunctionEqual];
   
    STAssertEqualObjects(@"6", [result stringNumberValue], nil);
}

- (void)test_1_Plus_2_Equal_3_Plus_4_Equal_7
{
    [self.numberCalc input:1];
    [self.numberCalc input:FunctionPlus];
    [self.numberCalc input:2];
    [self.numberCalc input:FunctionEqual];
    [self.numberCalc input:3];
    [self.numberCalc input:FunctionPlus];
    [self.numberCalc input:4];
    CalcValue *result = [self.numberCalc input:FunctionEqual];

    STAssertEqualObjects(@"7", [result stringNumberValue], nil);
}

- (void)test_1_Decimal_4_Plus_2_Eaual_3_Decimal_4
{
    [self.numberCalc input:1];
    [self.numberCalc input:FunctionDecimal];
    [self.numberCalc input:4];
    [self.numberCalc input:FunctionPlus];
    [self.numberCalc input:2];
    CalcValue *result = [self.numberCalc input:FunctionEqual];
   
    STAssertEqualObjects(@"3.4", [result stringNumberValue], nil);
}

- (void)test_1_Plus_2_Decimal_3_Eaual_3_Decimal_3
{
    [self.numberCalc input:1];
    [self.numberCalc input:FunctionPlus];
    [self.numberCalc input:2];
    [self.numberCalc input:FunctionDecimal];
    [self.numberCalc input:3];
    CalcValue *result = [self.numberCalc input:FunctionEqual];

    STAssertEqualObjects(@"3.3", [result stringNumberValue], nil);
}

- (void)test_1_Decimal_5_Plus_2_Decimal_3_Eaual_3_Decimal_8
{
    [self.numberCalc input:1];
    [self.numberCalc input:FunctionDecimal];
    [self.numberCalc input:5];
    [self.numberCalc input:FunctionPlus];
    [self.numberCalc input:2];
    [self.numberCalc input:FunctionDecimal];
    [self.numberCalc input:3];
    CalcValue *result = [self.numberCalc input:FunctionEqual];

    STAssertEqualObjects(@"3.8", [result stringNumberValue], nil);
}

- (void)test_Decimal_5_Plus_Decimal_8_Eaual_1_Decimal_3
{
    [self.numberCalc input:FunctionDecimal];
    [self.numberCalc input:5];
    [self.numberCalc input:FunctionPlus];
    [self.numberCalc input:FunctionDecimal];
    [self.numberCalc input:8];
    CalcValue *result = [self.numberCalc input:FunctionEqual];

    STAssertEqualObjects(@"1.3", [result stringNumberValue], nil);
}
@end
