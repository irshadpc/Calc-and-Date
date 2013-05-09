//
//  CalcValueFormatterTests.m
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/21.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import "CalcValueFormatterTests.h"
#import "CalcValue.h"
#import "CalcValueFormatter.h"

@interface CalcValueFormatterTests ()
@property(strong, nonatomic) CalcValueFormatter *formatter;
@end

@implementation CalcValueFormatterTests

- (void)setUp
{
    self.formatter = [[CalcValueFormatter alloc] init];
}

- (void)test123456789012_Should_123_456_789_012
{
    CalcValue *calcValue = [CalcValue calcValueWithDecimalNumber:[NSDecimalNumber decimalNumberWithString:@"123456789012"]];
    STAssertEqualObjects(@"123,456,789,012", [self.formatter displayValueWithCalcValue:calcValue], nil);
}

- (void)test_Decimal_000000000001_Should_0
{
    CalcValue *calcValue = [CalcValue calcValueWithDecimalNumber:[NSDecimalNumber decimalNumberWithString:@"0.000000000001"]];
    STAssertEqualObjects(@"0.00000000000", [self.formatter displayValueWithCalcValue:calcValue], nil);
}
@end
