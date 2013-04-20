//
//  DateCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "OldDateCalcTests.h"
#import "CalcController.h"
#import "CalcValue.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "NSDecimalNumber+Convert.h"

@interface OldDateCalcTests () {
  @private
    CalcController *_calcController;
}
@end

@implementation OldDateCalcTests
- (void)setUp
{
    _calcController = [[CalcController alloc] init];
}

- (void)testinputInteger_2012_1_1_Plus_2012_2_1_Equal
{
    [_calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 1
                                                day: 1]];
    [_calcController inputInteger:FunctionPlus];
    [_calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 2
                                                day: 1]];
    NSString *const result = [[_calcController inputInteger:FunctionEqual] stringValue];
    
    STAssertEqualObjects(@"31", result, @"RESULT: %@", result);
}

- (void)testinputInteger_2012_2_1_Plus_2012_1_1_Equal
{
    [_calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 2
                                                day: 1]];
    [_calcController inputInteger:FunctionPlus];
    [_calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 1
                                                day: 1]];
    NSString *const result = [[_calcController inputInteger:FunctionEqual] stringValue];
    
    STAssertEqualObjects(@"31", result, @"RESULT: %@", result);
}

- (void)testinputInteger_2012_1_1_Plus_31_Equal
{
    [_calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 1
                                                day: 1]];
    [_calcController inputInteger:FunctionPlus];
    [_calcController inputInteger:  3];
    [_calcController inputInteger:  1];
    NSString *const result = [[_calcController inputInteger:FunctionEqual] stringValue];
    
    STAssertEqualObjects(@"2012/02/01", result, @"RESULT: %@", result);
}

- (void)testinputInteger_31_Plus_2012_1_1_Equal
{
    [_calcController inputInteger:  3];
    [_calcController inputInteger:  1];
    [_calcController inputInteger:FunctionPlus];
    [_calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 1
                                                day: 1]];
    NSString *const result = [[_calcController inputInteger:FunctionEqual] stringValue];
    
    STAssertEqualObjects(@"2012/02/01", result, @"RESULT: %@", result);
}

- (void)testinputInteger_1_Plus_2_Plus_2012_12_01_Equal
{
    [_calcController inputInteger:  1];
    [_calcController inputInteger:FunctionPlus];
    [_calcController inputInteger:  2];
    [_calcController inputInteger:FunctionPlus];
    [_calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 12
                                                day: 1]];
    NSString *const result = [[_calcController inputInteger:FunctionEqual] stringValue];
    
    STAssertEqualObjects(@"2012/12/04", result, @"RESULT: %@", result);
}

- (void)testinputInteger_2012_12_1_Plus_2012_12_7_Plus_12_Equal
{
    [_calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 12
                                                day: 1]];
    [_calcController inputInteger:FunctionPlus];
    [_calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 12
                                                day: 7]];
    [_calcController inputInteger:FunctionPlus];
    [_calcController inputInteger:  1];
    [_calcController inputInteger:  2];
    NSString *const result = [[_calcController inputInteger:FunctionEqual] stringValue];
    
    STAssertEqualObjects(@"18", result, @"RESULT: %@", result);
}

- (void)testinputInteger2012_12_31_Plus_2013_1_2_Equal_Plus_2013_1_7_Plus_2013_1_20_Equal
{
    [_calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 12
                                                day: 31]];
    [_calcController inputInteger:FunctionPlus];
    [_calcController inputDate:[NSDate dateWithYear: 2013
                                              month: 1
                                                day: 2]];
    [_calcController inputInteger:FunctionEqual];
    [_calcController inputInteger:FunctionPlus];
    [_calcController inputDate:[NSDate dateWithYear: 2013
                                              month: 1
                                                day: 7]];
    NSString *const result1 = [[_calcController inputInteger:FunctionPlus] stringValue];
    
    STAssertEqualObjects(@"2013/01/09", result1, @"RESULT: %@", result1);
   
    [_calcController inputDate:[NSDate dateWithYear: 2013
                                              month: 1
                                                day: 20]];
    NSString *const result2 = [[_calcController inputInteger:FunctionEqual] stringValue];
    
    STAssertEqualObjects(@"11", result2, @"RESULT: %@", result2);
}
@end
