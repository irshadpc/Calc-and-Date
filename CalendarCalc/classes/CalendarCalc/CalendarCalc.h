//
//  CCCalendarCalc.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Function.h"
#import "Week.h"

@class CalendarCalcResult;
@class NumberCalculator;
@class DateCalculator;

@interface CalendarCalc : NSObject
@property (nonatomic, readonly) Function lastFunction;
@property (nonatomic, readonly) BOOL isAllCleared;

@property(strong, nonatomic) NumberCalculator *numberCalculator;
@property(strong, nonatomic) DateCalculator *dateCalculator;
@property(strong, nonatomic) CalendarCalcResult *result;
@property(nonatomic) Function currentFunction;
@property(nonatomic, getter=isEqual) BOOL equal;

- (CalendarCalcResult *)inputInteger:(NSInteger)integer;
- (CalendarCalcResult *)inputDate:(NSDate *)date;
- (CalendarCalcResult *)inputString:(NSString *)string;
- (CalendarCalcResult *)inputFunction:(Function)function;
- (void)setWeek:(Week)week exclude:(BOOL)exclude;
@end
