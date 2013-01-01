//
//  CCCalendarCalcResult.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/08.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCCalcType.h"

@class CCNumberResult;
@class CCDateResult;

@interface CCCalendarCalcResult : NSObject {
  @private
    NSString *_displayResult;
    CCNumberResult *_numberResult;
    CCDateResult *_dateResult;
    CCCalcType _calcType;
}

- (void)endInput;
- (void)clear;
- (CCCalendarCalcResult *)clearEntry;
- (void)updateDisplayResult;
- (NSString *)displayResult;
@end
