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

@implementation CalcValueFormatterTests
- (void)test123456789012_Should_123_456_789_012
{
    CalcValue *calcValue = [CalcValue calcValueWithDecimalNumber:[NSDecimalNumber decimalNumberWithString:@"123456789012"]];
    STAssertEqualObjects(@"123,456,789,012", [CalcValueFormatter displayNumberWithCalcValue:calcValue], nil);
}
@end
