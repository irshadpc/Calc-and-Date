//
//  NumberCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/13.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "NumberCalcTests.h"
#import "CalcController.h"
#import "CalcValue.h"
#import "CalcValueFormatter.h"
#import "Function.h"

@interface NumberCalcTests ()
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) CalcValueFormatter *formatter;
@end

@implementation NumberCalcTests
- (void)setUp
{
    self.calcController = [[CalcController alloc] init];
    self.formatter = [[CalcValueFormatter alloc] initWithCalcController:self.calcController];
}


#pragma mark - input

- (void)test_123
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:3];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"123", result, nil);
}

- (void)test_1234567890
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:4];
    [self.calcController inputInteger:5];
    [self.calcController inputInteger:6];
    [self.calcController inputInteger:7];
    [self.calcController inputInteger:8];
    [self.calcController inputInteger:9];
    [self.calcController inputInteger:0];
    NSString *result = [self.formatter displayValue];
   
    STAssertEqualObjects(@"1,234,567,890", result, nil);

}

- (void)test_12_Decimal_3
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:3];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"12.3", result, nil);
}

- (void)test_Decimal_3
{
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:3];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"0.3", result, nil);
}

- (void)test_Decimal
{
    [self.calcController inputInteger:FunctionDecimal];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"0.", result, nil);
}


#pragma mark - Calc

- (void)test_1_Plus_2_Equal_3
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValue];
   
    STAssertEqualObjects(@"3", result, nil);
}

- (void)test_1_Minus_2_Equal_Minus1
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionMinus];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"-1", result, nil);
}

- (void)test_2_Multi_3_Equal_6
{
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionMultiply];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"6", result, nil);
}

- (void)test_6_Div_2_Equal_3
{
    [self.calcController inputInteger:6];
    [self.calcController inputInteger:FunctionDivide];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"3", result, nil);
}

- (void)test_1_Plus_2_Plus_3_Equal_6
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValue];
   
    STAssertEqualObjects(@"6", result, nil);
}

- (void)test_1_Plus_2_Equal_3_Plus_4_Equal_7
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:4];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"7", result, nil);
}

- (void)test_1_Decimal_4_Plus_2_Eaual_3_Decimal_4
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:4];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValue];
   
    STAssertEqualObjects(@"3.4", result, nil);
}

- (void)test_1_Plus_2_Decimal_3_Eaual_3_Decimal_3
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"3.3", result, nil);
}

- (void)test_1_Decimal_5_Plus_2_Decimal_3_Eaual_3_Decimal_8
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:5];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"3.8", result, nil);
}

- (void)test_Decimal_5_Plus_Decimal_8_Eaual_1_Decimal_3
{
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:5];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:8];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValue];

    STAssertEqualObjects(@"1.3", result, nil);
}
@end
