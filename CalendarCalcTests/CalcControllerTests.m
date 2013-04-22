//
//  CalcControllerTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/15.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcControllerTests.h"
#import "CalcController.h"
#import "CalcValue.h"
#import "CalcValueFormatter.h"
#import "Function.h"
#import "NSDate+AdditionalConvenienceConstructor.h"

@interface CalcControllerTests ()
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) CalcValueFormatter *formatter;
@end

@implementation CalcControllerTests
- (void)setUp
{
    self.calcController = [[CalcController alloc] init];
    self.formatter = [[CalcValueFormatter alloc] init];
}

- (void)test_123_Clear
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:3];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionClear]];
   
    STAssertEqualObjects(@"0", result, nil);
}

- (void)test_1234567890123
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
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:3]];
   
    STAssertEqualObjects(@"123,456,789,013", result, nil);
}

- (void)test_12345678901_Decimal_2
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
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionDecimal];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:2]];
   
    STAssertEqualObjects(@"12,345,678,901.2", result, nil);
}

- (void)test_123_PlusMinus
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:3];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionPlusMinus]];

    STAssertEqualObjects(@"-123", result, nil);
}

- (void)test_123_Delete
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:3];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionDelete]];

    STAssertEqualObjects(@"12", result, nil);
}

- (void)test_123_Decimal_Delete
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionDecimal];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionDelete]];

    STAssertEqualObjects(@"123", result, nil);
}

- (void)test_123_Decimal_4_Delete
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionDecimal];
    [self.calcController inputInteger:4];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionDelete]];

    STAssertEqualObjects(@"123.", result, nil);
}

- (void)test_1_Plus_12_Clear_23_Equal_24
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionClear];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:3];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"24", result, nil);
}

- (void)test_12_PlusMinus_Plus_3_Equal_Minus_9
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionPlusMinus];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
    
    STAssertEqualObjects(@"-9", result, nil);
}

- (void)test_10_Plus_42_Delete_Equal_14
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:4];
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:FunctionDelete];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"14", result, nil);
}

- (void)test_10_Plus_3_Plus_Minus_4_Equal_9
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:FunctionMinus];
    [self.calcController inputInteger:4];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"9", result, nil);
}

- (void)test_10_Plus_3_Equal_Equal_16
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"16", result, nil);
}

- (void)test_3_Plus_4_Plus_20130501_Equal_20130508
{
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:4];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:5 day:1]];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"2013/05/08", result, nil);
}

- (void)test_20_Multi_20130501_Plus_20130510_Equal_180
{
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionMultiply];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:5 day:1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:5 day:10]];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"180", result, nil);
}

- (void)test_20_Plus_3_Clear_Clear_1_Plus_4_Equal_5
{
    [self.calcController inputInteger:2];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionClear];
    [self.calcController inputInteger:FunctionClear];
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:4];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"5", result, nil);
}

- (void)test_10_Plus_3_Equal_Clear_4_Plus_3_Equal_7
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:0];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputInteger:FunctionClear];
    [self.calcController inputInteger:4];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:3];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"7", result, nil);
}
@end
