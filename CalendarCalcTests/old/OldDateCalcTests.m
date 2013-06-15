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
#import "CalcValueFormatter.h"
#import "NSDate+AdditionalConvenienceConstructor.h"
#import "NSDate+Component.h"
#import "NSDecimalNumber+Convert.h"

@interface OldDateCalcTests () 
@property(strong, nonatomic) CalcController *calcController;
@property(strong, nonatomic) CalcValueFormatter *formatter;
@end

@implementation OldDateCalcTests
- (void)setUp
{
    self.calcController = [[CalcController alloc] init];
    self.formatter = [[CalcValueFormatter alloc] initWithCalcController:self.calcController];
}

- (void)testinputInteger_2012_1_1_Plus_2012_2_1_Equal
{
    [self.calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 1
                                                day: 1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 2
                                                day: 1]];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];
    
    STAssertEqualObjects(@"31", result, @"RESULT: %@", result);
}

- (void)testinputInteger_2012_2_1_Plus_2012_1_1_Equal
{
    [self.calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 2
                                                day: 1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 1
                                                day: 1]];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];
    
    STAssertEqualObjects(@"31", result, @"RESULT: %@", result);
}

- (void)testinputInteger_2012_1_1_Plus_31_Equal
{
    [self.calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 1
                                                day: 1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:  3];
    [self.calcController inputInteger:  1];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];
    
    STAssertEqualObjects(@"2012/02/01", result, @"RESULT: %@", result);
}

- (void)testinputInteger_31_Plus_2012_1_1_Equal
{
    [self.calcController inputInteger:  3];
    [self.calcController inputInteger:  1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 1
                                                day: 1]];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];
    
    STAssertEqualObjects(@"2012/02/01", result, @"RESULT: %@", result);
}

- (void)testinputInteger_1_Plus_2_Plus_2012_12_01_Equal
{
    [self.calcController inputInteger:  1];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:  2];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 12
                                                day: 1]];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];
    
    STAssertEqualObjects(@"2012/12/04", result, @"RESULT: %@", result);
}

- (void)testinputInteger_2012_12_1_Plus_2012_12_7_Plus_12_Equal
{
    [self.calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 12
                                                day: 1]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 12
                                                day: 7]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputInteger:  1];
    [self.calcController inputInteger:  2];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result = [self.formatter displayValue];
    
    STAssertEqualObjects(@"18", result, @"RESULT: %@", result);
}

- (void)testinputInteger2012_12_31_Plus_2013_1_2_Equal_Plus_2013_1_7_Plus_2013_1_20_Equal
{
    [self.calcController inputDate:[NSDate dateWithYear: 2012
                                              month: 12
                                                day: 31]];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear: 2013
                                              month: 1
                                                day: 2]];
    [self.calcController inputInteger:FunctionEqual];
    [self.calcController inputInteger:FunctionPlus];
    [self.calcController inputDate:[NSDate dateWithYear: 2013
                                              month: 1
                                                day: 7]];
    [self.calcController inputInteger:FunctionPlus];
    NSString *const result1 = [self.formatter displayValue];
    
    STAssertEqualObjects(@"2013/01/09", result1, @"RESULT: %@", result1);
   
    [self.calcController inputDate:[NSDate dateWithYear: 2013
                                              month: 1
                                                day: 20]];
    [self.calcController inputInteger:FunctionEqual];
    NSString *const result2 = [self.formatter displayValue];
    
    STAssertEqualObjects(@"11", result2, @"RESULT: %@", result2);
}
@end
