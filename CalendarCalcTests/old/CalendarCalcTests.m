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
#import "CalcValueFormatter.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "NSDecimalNumber+Convert.h"

@interface CalendarCalcTests () {
  @private
    CalcController *_calcController;
}
@property(strong, nonatomic) CalcValueFormatter *formatter;
@end

@implementation CalendarCalcTests
- (void)setUp 
{
    _calcController = [[CalcController alloc] init];
    self.formatter = [[CalcValueFormatter alloc] init];
}

- (void)testCalendarCalc
{
    STAssertNotNil(_calcController, @"CalendarCalc is nil");
}

- (void)testInputNumber_1
{
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger:1]];
    STAssertEqualObjects(@"1", result, @"RESULT: %@", result);
}

- (void)testInputNumber_12
{
    [_calcController inputInteger: 1];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger: 2]];
    
    STAssertEqualObjects(@"12", result, @"RESULT: %@", result);
}

- (void)testInputNumber_12_Point_3
{
    [_calcController inputInteger:  1];
    [_calcController inputInteger:  2];
    [_calcController inputInteger:FunctionDecimal];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger:  3]];
    
    STAssertEqualObjects(@"12.3", result, @"RESULT: %@", result);
}

- (void)testInputNumber_12_PlusMinus 
{
    [_calcController inputInteger:  1];
    [_calcController inputInteger:  2];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger:FunctionPlusMinus]];
    
    STAssertEqualObjects(@"-12", result, @"RESULT: %@", result);
}

- (void)testInputDate_2012_12_15
{
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputDate:[NSDate dateWithYear: 2012
                                                                      month: 12
                                                                        day: 15]]];
    STAssertEqualObjects(@"2012/12/15", result, @"RESULT: %@", result);
}

- (void)testinputInteger_20_Minus_30_Equal_PlusMinus_Minus_3_Equal
{
    [_calcController inputInteger:  2];
    [_calcController inputInteger:  0];
    [_calcController inputInteger:FunctionMinus];
    [_calcController inputInteger:  3];
    [_calcController inputInteger:  0];
    [_calcController inputInteger:FunctionEqual];
    [_calcController inputInteger:FunctionPlusMinus];
    NSString *const result1 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger:FunctionMinus]];
    
    STAssertEqualObjects(@"10", result1, @"RESULT: %@", result1);
    
    [_calcController inputInteger:  3];
    NSString *const result2 = [self.formatter displayValueWithCalcValue:[_calcController inputInteger:FunctionEqual]];
    
    STAssertEqualObjects(@"7", result2, @"RESULT: %@", result2);
}

- (void)testInputNumber_2_Multiply_00_Point_88_Equal
{
    [_calcController inputInteger:  2];
    [_calcController inputInteger:FunctionMultiply];
    [_calcController inputInteger:  0];
    [_calcController inputInteger:FunctionDecimal];
    [_calcController inputInteger:  0];
    [_calcController inputInteger:  8];
    [_calcController inputInteger:  8];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger:FunctionEqual]];
    
    STAssertEqualObjects(@"0.176", result, @"RESULT: %@", result);
}

- (void)testInputNumber_4_Multiply_3_Equal_3_Multiply_2_Equal
{
    [_calcController inputInteger:  4];
    [_calcController inputInteger:FunctionMultiply];
    [_calcController inputInteger:  3];
    [_calcController inputInteger:FunctionEqual];
    [_calcController inputInteger:  3];
    [_calcController inputInteger:FunctionMultiply];
    [_calcController inputInteger:  2];
    NSString *const result = [self.formatter displayValueWithCalcValue:[_calcController inputInteger:FunctionEqual]];
    
    STAssertEqualObjects(@"6", result, @"RESULT: %@", result);
}
@end
