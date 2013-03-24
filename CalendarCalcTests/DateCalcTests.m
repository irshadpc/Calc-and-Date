//
//  DateCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "DateCalcTests.h"
#import "CalendarCalc.h"
#import "CalendarCalcResult.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "NSDecimalNumber+Convert.h"

@interface DateCalcTests () {
  @private
    CalendarCalc *_calendarCalc;
}
@end

@implementation DateCalcTests

- (void)setUp
{
    _calendarCalc = [[CalendarCalc alloc] init];
}

- (void)testInputFunction_2012_1_1_Plus_2012_2_1_Equal
{
    [_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                            month: 1
                                              day: 1]];
    [_calendarCalc inputFunction:FunctionPlus];
    [_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                            month: 2
                                              day: 1]];
    [_calendarCalc inputFunction:FunctionEqual];

    
    NSString *const result = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"31", result, @"RESULT: %@", result);
}

- (void)testInputFunction_2012_2_1_Plus_2012_1_1_Equal
{
    [_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                            month: 2
                                              day: 1]];
    [_calendarCalc inputFunction:FunctionPlus];
    [_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                            month: 1
                                              day: 1]];
    [_calendarCalc inputFunction:FunctionEqual];


    NSString *const result = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"31", result, @"RESULT: %@", result);
}

- (void)testInputFunction_2012_1_1_Plus_31_Equal
{
    [_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                            month: 1
                                              day: 1]];
    [_calendarCalc inputFunction:FunctionPlus];
    [_calendarCalc inputInteger:  3];
    [_calendarCalc inputInteger:  1];
    [_calendarCalc inputFunction:FunctionEqual];


    NSString *const result = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"2012/02/01", result, @"RESULT: %@", result);
}

- (void)testInputFunction_31_Plus_2012_1_1_Equal
{
    [_calendarCalc inputInteger:  3];
    [_calendarCalc inputInteger:  1];
    [_calendarCalc inputFunction:FunctionPlus];
    [_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                            month: 1
                                              day: 1]];
    [_calendarCalc inputFunction:FunctionEqual];


    NSString *const result = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"2012/02/01", result, @"RESULT: %@", result);
}

- (void)testInputFunction_1_Plus_2_Plus_2012_12_01_Equal
{
    [_calendarCalc inputInteger:  1];
    [_calendarCalc inputFunction:FunctionPlus];
    [_calendarCalc inputInteger:  2];
    [_calendarCalc inputFunction:FunctionPlus];
    [_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                            month: 12
                                              day: 1]];
    [_calendarCalc inputFunction:FunctionEqual];

    NSString *const result = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"2012/12/04", result, @"RESULT: %@", result);
}

- (void)testInputFunction_2012_12_1_Plus_2012_12_7_Plus_12_Equal
{
    [_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                            month: 12
                                              day: 1]];
    [_calendarCalc inputFunction:FunctionPlus];
    [_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                            month: 12
                                              day: 7]];
    [_calendarCalc inputFunction:FunctionPlus];
    [_calendarCalc inputInteger:  1];
    [_calendarCalc inputInteger:  2];
    [_calendarCalc inputFunction:FunctionEqual];

    NSString *const result = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"18", result, @"RESULT: %@", result);
}

- (void)testInputFunction2012_12_31_Plus_2013_1_2_Equal_Plus_2013_1_7_Plus_2013_1_20_Equal
{
    [_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                            month: 12
                                              day: 31]];
    [_calendarCalc inputFunction:FunctionPlus];
    [_calendarCalc inputDate:[NSDate dateWithYear: 2013
                                            month: 1
                                              day: 2]];
    [_calendarCalc inputFunction:FunctionEqual];
    [_calendarCalc inputFunction:FunctionPlus];
    [_calendarCalc inputDate:[NSDate dateWithYear: 2013
                                            month: 1
                                              day: 7]];
    [_calendarCalc inputFunction:FunctionPlus];
   
    NSString *const result1 = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"2013/01/09", result1, @"RESULT: %@", result1);
   
    [_calendarCalc inputDate:[NSDate dateWithYear: 2013
                                            month: 1
                                              day: 20]];
    [_calendarCalc inputFunction:FunctionEqual];
       
    NSString *const result2 = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"11", result2, @"RESULT: %@", result2);
}

@end
