//
//  CCCalendarCalc.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Decimal = 301,
    Equal,
    Plus,
    Minus,
    Multiply,
    Divide,
    Clear,
    PlusMinus,
    Delete,
    
    FUNCTION_END,
} CCFunction;


@class CCCalendarCalcResult;
@class CCNumberCalculator;
@class CCDateCalculator;

@interface CCCalendarCalc : NSObject {
  @private
    CCNumberCalculator *_numberCalculator;
    CCDateCalculator *_dateCalculator;
}
- (CCCalendarCalcResult *)inputNumber:(NSDecimalNumber *)number;
- (CCCalendarCalcResult *)inputDate:(NSDate *)date;
- (CCCalendarCalcResult *)inputFunction:(CCFunction)function;
@end
