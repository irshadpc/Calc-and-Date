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
#import "NSDecimalNumber+Convert.h"

@interface OldNumberCalcTests () {
  @private
    CalcController *_calendarCalc;
}
@end

@implementation OldNumberCalcTests

//- (void)setUp
//{
//    _calendarCalc = [[CalendarCalc alloc] init];
//}
//
//- (void)testInputFunction_1_Plus_2_Equal
//{
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
//}
//
//- (void)testInputFunction_2_Minus_1_Equal
//{
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction: FunctionMinus];
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
//}
//
//- (void)testInputFunction_2_Multiply_3_Equal
//{
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction: FunctionMultiply];
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"6", result, @"RESULT: %@", result);
//}
//
//- (void)testInputFunction_6_Divide_2_Equal
//{
//    [_calendarCalc inputInteger:  6];
//    [_calendarCalc inputFunction: FunctionDivide];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
//}
//
//- (void)testInputFunction_1_Plus_20_Equal
//{
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  2];
//
//    NSString *const result1 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"2", result1, @"RESULT1: %@", result1);
//    
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    NSString *const result2 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"21", result2, @"RESULT2: %@", result2);
//}
//
//- (void)testInputFunction_1_Plus_20_Minus_10_Equal
//{
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputFunction: FunctionMinus];
//
//    NSString *const result1 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"21", result1, @"RESULT1: %@", result1);
//    
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    NSString *const result2 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"11", result2, @"RESULT2: %@", result2);
//}
//
//- (void)testInputFunction_3_Plus_Minus_2_Equal
//{
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputFunction: FunctionMinus];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
//}
//
//- (void)testInputFunction_3_Plus_1_Plus_Multiply_4_Equal
//{
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputFunction: FunctionMultiply];
//    [_calendarCalc inputInteger:  4];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"16", result, @"RESULT: %@", result);
//}
//
//- (void)testInputFunction_12_Decimal_01_Plus_4_Equal
//{
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction: FunctionDecimal];
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputInteger:  1];
//
//    NSString *const result1 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"12.01", result1, @"RESULT1: %@", result1);
//
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  4];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    NSString *const result2 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"16.01", result2, @"RESULT: %@", result2);
//}
//
//- (void)testInputFunction_21_Plus_3_Equal_4_Plus_12_Equal
//{
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    [_calendarCalc inputInteger:  4];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction: FunctionEqual];
//
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"16", result, @"RESULT: %@", result);
//}
//
//- (void)testInputFunction_12_Plus_3_Equal_PlusMinus_Plus_9_Equal
//{
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction: FunctionEqual];
//    [_calendarCalc inputFunction: FunctionPlusMinus];
//
//    NSString *const result1 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"-15", result1, @"RESULT1: %@", result1);
//
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  9];
//    [_calendarCalc inputFunction: FunctionEqual];
//   
//    NSString *const result2 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"-6", result2, @"RESULT: %@", result2);
//}
//
//- (void)testInputFunction_10_Plus_30_Equal_Plus_10_Equal
//{
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputFunction: FunctionEqual];
//    [_calendarCalc inputFunction: FunctionPlus];
//
//    NSString *const result1 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"40", result1, @"RESULT: %@", result1);
//   
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputFunction: FunctionEqual];
//   
//    NSString *const result2 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"50", result2, @"RESULT: %@", result2);
//}
//
//- (void)testInputFunction_12_Plus_3_Equal_Clear_Plus_3_Equal
//{
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction: FunctionEqual];
//    [_calendarCalc inputFunction: FunctionClear];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction: FunctionEqual];
//   
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
//}
//
//- (void)testInputFunction_3_Plus_4_Equal_Decimal_2_Plus_1_Equal
//{
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  4];
//    [_calendarCalc inputFunction: FunctionEqual];
//    [_calendarCalc inputFunction: FunctionDecimal];
//    [_calendarCalc inputInteger:  2];
//    
//    NSString *const result1 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"0.2", result1, @"RESULT: %@", result1);
//
//    [_calendarCalc inputFunction: FunctionPlus];
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputFunction: FunctionEqual];
//   
//    NSString *const result2 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"1.2", result2, @"RESULT: %@", result2);
//}
@end
