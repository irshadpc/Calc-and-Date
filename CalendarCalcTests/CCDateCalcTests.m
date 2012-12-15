//
//  CCDateCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCDateCalcTests.h"
#import "CCCalendarCalc.h"
#import "CCCalendarCalcResult.h"
#import "NSDate+Component.h"
#import "NSDecimalNumber+Convert.h"

@interface CCDateCalcTests () {
  @private
    CCCalendarCalc *_calendarCalc;
}

- (NSDecimalNumber *)decimal:(NSString *)string;
@end

@implementation CCDateCalcTests

- (void)setUp
{
    _calendarCalc = [[CCCalendarCalc alloc] init];
}

- (void)testInputFunction_2012_1_1_Plus_2012_2_1_Equal
{
    [_calendarCalc inputDate: [NSDate dateWithYear: 2012
                                             month: 1
                                               day: 1]];
    [_calendarCalc inputFunction: CCPlus];
    [_calendarCalc inputDate: [NSDate dateWithYear: 2012
                                             month: 2
                                               day: 1]];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"31", result, @"RESULT: %@", result);
}

- (void)testInputFunction_2012_2_1_Plus_2012_1_1_Equal
{
    [_calendarCalc inputDate: [NSDate dateWithYear: 2012
                                             month: 2
                                               day: 1]];
    [_calendarCalc inputFunction: CCPlus];
    [_calendarCalc inputDate: [NSDate dateWithYear: 2012
                                             month: 1
                                               day: 1]];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"31", result, @"RESULT: %@", result);
}

- (void)testInputFunction_2012_1_1_Plus_31_Equal
{
    [_calendarCalc inputDate: [NSDate dateWithYear: 2012
                                             month: 1
                                               day: 1]];
    [_calendarCalc inputFunction: CCPlus];
    [_calendarCalc inputNumber:DecimalNumber(@"31")];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"2012/02/01", result, @"RESULT: %@", result);
}

- (void)testInputFunction_31_Plus_2012_1_1_Equal
{
    [_calendarCalc inputNumber:DecimalNumber(@"31")];
    [_calendarCalc inputFunction: CCPlus];
    [_calendarCalc inputDate: [NSDate dateWithYear: 2012
                                             month: 1
                                               day: 1]];
    NSString *const result = [[_calendarCalc inputFunction: CCEqual] displayResult];
    STAssertEqualObjects(@"2012/02/01", result, @"RESULT: %@", result);
}



#pragma mark - Private

- (NSDecimalNumber *)decimal:(NSString *)string
{
    return [NSDecimalNumber decimalNumberWithString: string];
}
@end
