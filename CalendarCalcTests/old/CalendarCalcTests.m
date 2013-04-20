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
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "NSDecimalNumber+Convert.h"

@interface CalendarCalcTests () {
  @private
    CalcController *_calendarCalc;
}
@end

@implementation CalendarCalcTests

//- (void)setUp 
//{
//    _calendarCalc = [[CalcController alloc] init];
//}
//
//- (void)testCalendarCalc
//{
//    STAssertNotNil(_calendarCalc, @"CalendarCalc is nil");
//}
//
//- (void)testInputNumber_1
//{
//    NSString *const result = [[_calendarCalc inputInteger:1] displayResult];
//    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
//}
//
//- (void)testInputNumber_12
//{
//    [_calendarCalc inputInteger: 1];
//    [_calendarCalc inputInteger: 2];
//
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"12", result, @"RESULT: %@", result);
//}
//
//- (void)testInputNumber_12_Point_3
//{
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction:FunctionDecimal];
//    [_calendarCalc inputInteger:  3];
//
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"12.3", result, @"RESULT: %@", result);
//}
//
//- (void)testInputNumber_12_PlusMinus 
//{
//    [_calendarCalc inputInteger:  1];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction:FunctionPlusMinus];
//   
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"-12", result, @"RESULT: %@", result);
//}
//
//- (void)testInputDate_2012_12_15
//{
//    NSString *const result = [[_calendarCalc inputDate:[NSDate dateWithYear: 2012
//                                                                      month: 12
//                                                                        day: 15]] displayResult];
//    STAssertEqualObjects(@"2012/12/15", result, @"RESULT: %@", result);
//}
//
//- (void)testInputFunction_20_Minus_30_Equal_PlusMinus_Minus_3_Equal
//{
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputFunction:FunctionMinus];
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputFunction:FunctionEqual];
//    [_calendarCalc inputFunction:FunctionPlusMinus];
//    [_calendarCalc inputFunction:FunctionMinus];
//    
//    NSString *const result1 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"10", result1, @"RESULT: %@", result1);
//    
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction:FunctionEqual];
//   
//    NSString *const result2 = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"7", result2, @"RESULT: %@", result2);
//}
//
//- (void)testInputNumber_2_Multiply_00_Point_88_Equal
//{
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction:FunctionMultiply];
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputFunction:FunctionDecimal];
//    [_calendarCalc inputInteger:  0];
//    [_calendarCalc inputInteger:  8];
//    [_calendarCalc inputInteger:  8];
//    [_calendarCalc inputFunction:FunctionEqual];
//   
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"0.176", result, @"RESULT: %@", result);
//}
//
//- (void)testInputNumber_4_Multiply_3_Equal_3_Multiply_2_Equal
//{
//    [_calendarCalc inputInteger:  4];
//    [_calendarCalc inputFunction:FunctionMultiply];
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction:FunctionEqual];
//    [_calendarCalc inputInteger:  3];
//    [_calendarCalc inputFunction:FunctionMultiply];
//    [_calendarCalc inputInteger:  2];
//    [_calendarCalc inputFunction:FunctionEqual];
//    
//    NSString *const result = [[_calendarCalc result] displayResult];
//    STAssertEqualObjects(@"6", result, @"RESULT: %@", result);
//}

@end
