//
//  CalcValueFormatterTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/21.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcValueFormatterTests.h"
#import "CalcController.h"
#import "CalcValue.h"
#import "CalcControllerFormatter.h"

@interface CalcValueFormatterTests ()
@property(strong, nonatomic) CalcControllerFormatter *formatter;
@property(strong, nonatomic) CalcController *controller;
@end

@implementation CalcValueFormatterTests

- (void)setUp
{
    self.controller = [[CalcController alloc] init];
    self.formatter = [[CalcControllerFormatter alloc] initWithCalcController:self.controller];
}

- (void)test123456789012_Should_123_456_789_012
{
    [self.controller setStringValue:@"123456789012"];
    STAssertEqualObjects(@"123,456,789,012", [self.formatter displayValue], nil);
}

- (void)test_Decimal_000000000001_Should_0
{
    [self.controller setStringValue:@"0.000000000001"];
    STAssertEqualObjects(@"0.00000000000", [self.formatter displayValue], nil);
}
@end
