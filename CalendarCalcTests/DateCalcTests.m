//
//  DateCalcTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/14.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "DateCalcTests.h"
#import "DateCalc.h"
#import "CalcValue.h"
#import "Function.h"
#import "NSDate+AdditionalConvenienceConstructor.h"

@interface DateCalcTests ()
@property(strong, nonatomic) DateCalc *dateCalc;
@end

@implementation DateCalcTests
- (void)setUp
{
    self.dateCalc = [[DateCalc alloc] init];
}


#pragma mark - input

- (void)test_20130401
{
    CalcValue *result = [self.dateCalc inputWithDate:[NSDate dateWithYear:2013 month:4 day:1]];
   
    STAssertEqualObjects(@"2013/04/01", [result stringDateValue], nil);
}

- (void)test_123
{
    [self.dateCalc inputWithInteger:1];
    [self.dateCalc inputWithInteger:2];
    CalcValue *result = [self.dateCalc inputWithInteger:3];

    STAssertEqualObjects(@"123", [result stringNumberValue], nil);
}


#pragma mrak - calc

- (void)test_20130401_Plus_7_Equal_20130408
{
    [self.dateCalc inputWithDate:[NSDate dateWithYear:2013 month:4 day:1]];
    [self.dateCalc inputWithInteger:FunctionPlus];
    [self.dateCalc inputWithInteger:7];
    CalcValue *result = [self.dateCalc inputWithInteger:FunctionEqual];
   
    STAssertEqualObjects(@"2013/04/08", [result stringDateValue], nil);
}

- (void)test_8_Plus_20130401_Equal_20130409
{
    [self.dateCalc inputWithInteger:8];
    [self.dateCalc inputWithInteger:FunctionPlus];
    [self.dateCalc inputWithDate:[NSDate dateWithYear:2013 month:4 day:1]];
    CalcValue *result = [self.dateCalc inputWithInteger:FunctionEqual];
   
    STAssertEqualObjects(@"2013/04/09", [result stringDateValue], nil);
}
@end
