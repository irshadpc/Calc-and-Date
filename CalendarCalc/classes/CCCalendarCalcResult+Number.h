//
//  CCCalendarCalcResult+Number.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcResult.h"

@interface CCCalendarCalcResult (Number)
- (NSDecimalNumber *)numberResult;
- (CCCalendarCalcResult *)setNumberResult:(NSDecimalNumber *)number;

- (CCCalendarCalcResult *)clearEntry;
- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number;
- (CCCalendarCalcResult *)inputDecimalPoint;
@end
