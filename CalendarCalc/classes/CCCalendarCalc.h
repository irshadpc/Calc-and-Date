//
//  CCCalendarCalc.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CCDecimal = 301,
    CCEqual,
    CCPlus,
    CCMinus,
    CCMultiply,
    CCDivide,
    CCClear,
    CCPlusMinus,
    CCDelete,
    
    CCFunctionMax,
} CCFunction;


@class CCCalendarCalcResult;
@class CCNumberCalculator;
@class CCDateCalculator;

@interface CCCalendarCalc : NSObject {
  @private
    CCNumberCalculator *_numberCalculator;
    CCDateCalculator *_dateCalculator;
    CCCalendarCalcResult *_result;
    CCFunction _currentFunction;
}
- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number;
- (CCCalendarCalcResult *)inputDate:(NSDate *)date;
- (CCCalendarCalcResult *)inputFunction:(CCFunction)function;
@end
