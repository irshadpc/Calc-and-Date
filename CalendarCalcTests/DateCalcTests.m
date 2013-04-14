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
@end
