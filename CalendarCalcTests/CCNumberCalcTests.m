//
//  CCNumberCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCNumberCalcTests.h"
#import "CCCalendarCalc.h"
#import "CCCalendarCalcResult.h"
#import "NSDecimalNumber+Convert.h"

@interface CCNumberCalcTests () {
  @private
    CCCalendarCalc *_calendarCalc;
}
@end

@implementation CCNumberCalcTests

- (void)setUp
{
    _calendarCalc = [[CCCalendarCalc alloc] init];
}

- (void)testInputFunction_1_Plus_2_Equal
{
    [_calendarCalc inputNumber: DecimalNumber(@"1")];
    [_calendarCalc inputFunction: CCPlus];
    [_calendarCalc inputNumber: DecimalNumber(@"2")];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
}

- (void)testInputFunction_2_Minus_1_Equal
{
    [_calendarCalc inputNumber: DecimalNumber(@"2")];
    [_calendarCalc inputFunction: CCMinus];
    [_calendarCalc inputNumber: DecimalNumber(@"1")];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testInputFunction_2_Multiply_3_Equal
{
    [_calendarCalc inputNumber: DecimalNumber(@"2")];
    [_calendarCalc inputFunction: CCMultiply];
    [_calendarCalc inputNumber: DecimalNumber(@"3")];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"6", result, @"RESULT: %@", result);
}

- (void)testInputFunction_6_Divide_2_Equal
{
    [_calendarCalc inputNumber: DecimalNumber(@"6")];
    [_calendarCalc inputFunction: CCDivide];
    [_calendarCalc inputNumber: DecimalNumber(@"2")];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
}

- (void)testInputFunction_1_Plus_20_Equal
{
    [_calendarCalc inputNumber:DecimalNumber(@"1")];
    [_calendarCalc inputFunction: CCPlus];
    NSString *const result1 = [[_calendarCalc inputNumber:DecimalNumber(@"2")] displayResult];
    STAssertEqualObjects(@"2", result1, @"RESULT1: %@", result1);
    
    [_calendarCalc inputNumber:DecimalNumber(@"0")];
    NSString *const result2 = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"21", result2, @"RESULT2: %@", result2);
}

- (void)testInputFunction_1_Plus_20_Minus_10_Equal
{
    [_calendarCalc inputNumber:DecimalNumber(@"1")];
    [_calendarCalc inputFunction: CCPlus];
    [_calendarCalc inputNumber:DecimalNumber(@"2")];
    [_calendarCalc inputNumber:DecimalNumber(@"0")];
    NSString *const result1 = [[_calendarCalc inputFunction: CCMinus] displayResult];
    STAssertEqualObjects(@"21", result1, @"RESULT1: %@", result1);
    
    [_calendarCalc inputNumber:DecimalNumber(@"1")];
    [_calendarCalc inputNumber:DecimalNumber(@"0")];
    NSString *const result2 = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"11", result2, @"RESULT2: %@", result2);
}

- (void)testInputFunction_3_Plus_Minus_2_Equal
{
    [_calendarCalc inputNumber:DecimalNumber(@"3")];
    [_calendarCalc inputFunction: CCPlus];
    [_calendarCalc inputFunction: CCMinus];
    [_calendarCalc inputNumber:DecimalNumber(@"2")];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testInputFunction_3_Plus_1_Plus_Multiply_4_Equal
{
    [_calendarCalc inputNumber:DecimalNumber(@"3")];
    [_calendarCalc inputFunction: CCPlus];
    [_calendarCalc inputNumber:DecimalNumber(@"1")];
    [_calendarCalc inputFunction: CCPlus];
    [_calendarCalc inputFunction: CCMultiply];
    [_calendarCalc inputNumber:DecimalNumber(@"4")];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"16", result, @"RESULT: %@", result);
}

@end
