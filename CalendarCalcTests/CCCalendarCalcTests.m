//
//  CCCalendarCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcTests.h"
#import "CCCalendarCalc.h"
#import "CCCalendarCalcResult.h"
#import "CCCalendarCalcResult+Formatter.h"
#import "NSDate+Component.h"

@interface CCCalendarCalcTests () {
  @private
    CCCalendarCalc *_calendarCalc;
}

- (CCCalendarCalcResult *)inputString:(NSString *)string;
@end

@implementation CCCalendarCalcTests

- (void)setUp 
{
    _calendarCalc = [[CCCalendarCalc alloc] init];
}

- (void)testCalendarCalc
{
    STAssertNotNil(_calendarCalc, @"CalendarCalc is nil");
}

- (void)testInputNumber_1
{
    NSString *const result = [[self inputString: @"1"] displayResult];
    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testInputNumber_12
{
    [self inputString: @"1"];
    NSString *const result = [[self inputString: @"2"] displayResult];
    STAssertEqualObjects(@"12", result, @"RESULT: %@", result);
}

- (void)testInputFunction_1_Plus_2_Equal
{
    [self inputString: @"1"];
    [_calendarCalc inputFunction: CCPlus];
    [self inputString: @"2"];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
}

- (void)testInputFunction_2_Minus_1_Equal
{
    [self inputString: @"2"];
    [_calendarCalc inputFunction: CCMinus];
    [self inputString: @"1"];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testInputFunction_2_Multiply_3_Equal
{
    [self inputString: @"2"];
    [_calendarCalc inputFunction: CCMultiply];
    [self inputString: @"3"];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"6", result, @"RESULT: %@", result);
}

- (void)testInputFunction_6_Divide_2_Equal
{
    [self inputString: @"6"];
    [_calendarCalc inputFunction: CCDivide];
    [self inputString: @"2"];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"3", result, @"RESULT: %@", result);
}

- (void)testInputDate_2012_12_15
{
    NSString *const result = [[_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                                                      month: 12
                                                                        day: 15]] displayResult];
    STAssertEqualObjects(@"2012/12/15", result, @"RESULT: %@", result);
}


#pragma mark - Private

- (CCCalendarCalcResult *)inputString:(NSString *)string
{ 
    return [_calendarCalc inputNumber: [NSDecimalNumber decimalNumberWithString: string]];
}
@end
