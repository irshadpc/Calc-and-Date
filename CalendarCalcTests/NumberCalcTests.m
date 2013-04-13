//
//  NumberCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/13.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NumberCalcTests.h"
#import "NumberCalc.h"
#import "Result.h"
#import "Function.h"

@interface NumberCalcTests ()
@property(strong, nonatomic) NumberCalc *numberCalc;
@end

@implementation NumberCalcTests
- (void)setUp
{
    self.numberCalc = [[NumberCalc alloc] init];
}

- (void)test_123
{
    [self.numberCalc inputInteger:1];
    [self.numberCalc inputInteger:2];
    Result *result = [self.numberCalc inputInteger:3];

    STAssertEqualObjects(@"123", [result stringNumberValue], nil);
}

- (void)test_1_Plus_2_Equal_3
{
    [self.numberCalc inputInteger:1];
    [self.numberCalc inputFunction:FunctionPlus];
    [self.numberCalc inputInteger:2];
    Result *result = [self.numberCalc inputFunction:FunctionEqual];
   
    STAssertEqualObjects(@"3", [result stringNumberValue], nil);
}

- (void)test_1_Minus_2_Equal_Minus1
{
    [self.numberCalc inputInteger:1];
    [self.numberCalc inputFunction:FunctionMinus];
    [self.numberCalc inputInteger:2];
    Result *result = [self.numberCalc inputFunction:FunctionEqual];

    STAssertEqualObjects(@"-1", [result stringNumberValue], nil);
}

- (void)test_2_Multi_3_Equal_6
{
    [self.numberCalc inputInteger:2];
    [self.numberCalc inputFunction:FunctionMultiply];
    [self.numberCalc inputInteger:3];
    Result *result = [self.numberCalc inputFunction:FunctionEqual];

    STAssertEqualObjects(@"6", [result stringNumberValue], nil);
}

- (void)test_6_Div_2_Equal_3
{
    [self.numberCalc inputInteger:6];
    [self.numberCalc inputFunction:FunctionDivide];
    [self.numberCalc inputInteger:2];
    Result *result = [self.numberCalc inputFunction:FunctionEqual];

    STAssertEqualObjects(@"3", [result stringNumberValue], nil);
}

- (void)test_12_Decimal_3
{
    [self.numberCalc inputInteger:1];
    [self.numberCalc inputInteger:2];
    [self.numberCalc inputFunction:FunctionDecimal];
    Result *result =[self.numberCalc inputInteger:3];

    STAssertEqualObjects(@"12.3", [result stringNumberValue], nil);
}

- (void)test_Decimal_3
{
    [self.numberCalc inputFunction:FunctionDecimal];
    Result *result = [self.numberCalc inputInteger:3];

    STAssertEqualObjects(@"0.3", [result stringNumberValue], nil);
}

- (void)test_Decimal
{
    Result *result = [self.numberCalc inputFunction:FunctionDecimal];

    STAssertEqualObjects(@"0.", [result stringNumberValue], nil);
}
@end
