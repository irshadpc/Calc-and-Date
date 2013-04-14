//
//  CCCalendarCalcResult.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalcType.h"

@class NumberResult;
@class DateResult;

@interface CalendarCalcResult : NSObject {
  @private
    NSString *_displayResult;
    NumberResult *_numberResult;
    DateResult *_dateResult;
    CalcType _calcType;
}

- (void)endInput;
- (void)clear;
- (CalendarCalcResult *)clearEntry;
- (void)updateDisplayResult;
- (NSString *)displayResult;
@end
