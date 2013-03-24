//
//  CCCalendarCalcResult+Number.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CalendarCalcResult.h"

@interface CalendarCalcResult (Number)
+ (NSDecimalNumber *)numberFromString:(NSString *)string;

- (NSDecimalNumber *)numberResult;
- (void)setNumberResult:(NSDecimalNumber *)number;
- (void)setNumberResultForDisplay:(NSDecimalNumber *)number;

- (CalendarCalcResult *)inputNumber:(NSDecimalNumber *)number;
- (CalendarCalcResult *)inputDecimalPoint;
- (CalendarCalcResult *)reverseNumberResult;
@end
