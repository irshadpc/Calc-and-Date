//
//  CCCalendarCalcResult+Date.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import "CCCalendarCalcResult.h"

@interface CCCalendarCalcResult (Date)
+ (NSDate *)dateFromString:(NSString *)string;

- (NSDate *)dateResult;
- (void)setDateResult:(NSDate *)date;
- (void)setDateResultForDisplay:(NSDate *)date;

- (CCCalendarCalcResult *)inputDate:(NSDate *)date;
@end
