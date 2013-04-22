//
//  DateCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/14.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "DateCalcTests.h"
#import "CalcController.h"
#import "CalcValue.h"
#import "CalcValueFormatter.h"
#import "Function.h"
#import "NSDate+AdditionalConvenienceConstructor.h"

@interface DateCalcTests ()
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) CalcValueFormatter *formatter;
@end

@implementation DateCalcTests
- (void)setUp
{
    self.calcController = [[CalcController alloc] init];
    self.formatter = [[CalcValueFormatter alloc] init];
}


#pragma mark - input

- (void)test_20130401
{
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:1]]];
   
    STAssertEqualObjects(@"2013/04/01", result, nil);
}

- (void)test_123
{
    [self.calcController inputInteger:1];
    [self.calcController inputInteger:2];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:3]];

    STAssertEqualObjects(@"123", result, nil);
}


#pragma mrak - Calc Date&Date

- (void)test_20130401_Plus_7_Equal_20130408
{
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:7];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"2013/04/08", result, nil);
}

- (void)test_8_Plus_20130401_Equal_20130409
{
    [self.calcController inputInteger:8];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:1]];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"2013/04/09", result, nil);
}

- (void)test_20130401_Minus_7_Equal_20130325
{
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:1]];
    [self.calcController inputInteger:FunctionMinus];
    [self.calcController inputInteger:7];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];

    STAssertEqualObjects(@"2013/03/25", result, nil);
}

- (void)test_8_Minus_20130401_Equal_20130324
{
    [self.calcController inputInteger:8];
    [self.calcController inputInteger:FunctionMinus];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:1]];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];

    STAssertEqualObjects(@"2013/03/24", result, nil);
}

- (void)test_20130501_Plus_8_Plus_2_Equal_20130511
{
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:5 day:1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:8];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];

    STAssertEqualObjects(@"2013/05/11", result, nil);
}

- (void)test_20130501_Plus_8_Equal_20130601_Plus_2_Equal_20130603
{
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:5 day:1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:8];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:6 day:1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:2];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];

    STAssertEqualObjects(@"2013/06/03", result, nil);
}


#pragma mark - Calc Date&Number

- (void)test_20130401_Plus_20130409_Equal_8
{
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:9]];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];
   
    STAssertEqualObjects(@"8", result, nil);
}

- (void)test_20130401_Minus_20130409_Equal_Minus_8
{
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:1]];
    [self.calcController inputInteger:FunctionMinus];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:9]];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];

    STAssertEqualObjects(@"-8", result, nil);
}

- (void)test_20130401_Plus_20130409_Plus_20130501_Equal_20130509
{
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:9]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:5 day:1]];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];

    STAssertEqualObjects(@"2013/05/09", result, nil);
}

- (void)test_20130401_Plus_20130409_Equal_20130501_Plus_20130429_Equal_2

{
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:9]];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:5 day:1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear:2013 month:4 day:29]];
    NSString *result = [self.formatter displayValueWithCalcValue:[self.calcController inputInteger:FunctionEqual]];

    STAssertEqualObjects(@"2", result, nil);
}
@end
