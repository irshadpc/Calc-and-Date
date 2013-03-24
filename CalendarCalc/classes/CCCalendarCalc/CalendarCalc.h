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

@interface CalendarCalc : NSObject {
  @private
    NumberCalculator *_numberCalculator;
    DateCalculator *_dateCalculator;
    CalendarCalcResult *_result;
    Function _currentFunction;
    BOOL _isEqual;
}
@property (nonatomic, readonly) Function lastFunction;
@property (nonatomic, readonly) BOOL isAllCleared;

- (CalendarCalcResult *)inputInteger:(NSInteger)integer;
- (CalendarCalcResult *)inputDate:(NSDate *)date;
- (CalendarCalcResult *)inputString:(NSString *)string;
- (CalendarCalcResult *)inputFunction:(Function)function;
- (CalendarCalcResult *)result;
- (void)setWeek:(Week)week exclude:(BOOL)exclude;
@end
