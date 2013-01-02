//
//  CCCalendarCalc.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCFunction.h"
#import "ASCWeek.h"

@class CCCalendarCalcResult;
@class CCNumberCalculator;
@class CCDateCalculator;

@interface CCCalendarCalc : NSObject {
  @private
    CCNumberCalculator *_numberCalculator;
    CCDateCalculator *_dateCalculator;
    CCCalendarCalcResult *_result;
    CCFunction _currentFunction;
    BOOL _isEqual;
}
@property (nonatomic, readonly) CCFunction lastFunction;
@property (nonatomic, readonly) BOOL isAllCleared;

- (CCCalendarCalcResult *)inputInteger:(NSInteger)integer;
- (CCCalendarCalcResult *)inputDate:(NSDate *)date;
- (CCCalendarCalcResult *)inputString:(NSString *)string;
- (CCCalendarCalcResult *)inputFunction:(CCFunction)function;
- (CCCalendarCalcResult *)result;
- (void)setWeek:(ASCWeek)week exclude:(BOOL)exclude;
@end
