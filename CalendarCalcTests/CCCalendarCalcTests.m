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
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "NSDecimalNumber+Convert.h"

@interface CCCalendarCalcTests () {
  @private
    CCCalendarCalc *_calendarCalc;
}
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
    NSString *const result = [[_calendarCalc inputInteger:1] displayResult];
    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testInputNumber_12
{
    [_calendarCalc inputInteger: 1];
    [_calendarCalc inputInteger: 2];

    NSString *const result = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"12", result, @"RESULT: %@", result);
}

- (void)testInputNumber_12_Point_3
{
    [_calendarCalc inputInteger:  1];
    [_calendarCalc inputInteger:  2];
    [_calendarCalc inputFunction: CCDecimal];
    [_calendarCalc inputInteger:  3];

    NSString *const result = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"12.3", result, @"RESULT: %@", result);
}

- (void)testInputNumber_12_PlusMinus 
{
    [_calendarCalc inputInteger:  1];
    [_calendarCalc inputInteger:  2];
    [_calendarCalc inputFunction: CCPlusMinus];
   
    NSString *const result = [[_calendarCalc result] displayResult];
    STAssertEqualObjects(@"-12", result, @"RESULT: %@", result);
}

- (void)testInputDate_2012_12_15
{
    NSString *const result = [[_calendarCalc inputDate:[NSDate dateWithYear: 2012
                                                                      month: 12
                                                                        day: 15]] displayResult];
    STAssertEqualObjects(@"2012/12/15", result, @"RESULT: %@", result);
}

@end
