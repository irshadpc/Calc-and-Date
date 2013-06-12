//
//  CalcController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/14.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Week.h"
#import "Function.h"

@class CalcValue;
@interface CalcController : NSObject
@property(nonatomic, getter=isIncludeStartDay) BOOL includeStartDay;

- (CalcController *)inputInteger:(NSInteger)integer;
- (CalcController *)inputDate:(NSDate *)date;
- (CalcController *)setStringValue:(NSString *)stringValue;

- (Function)function;
- (CalcValue *)result;
- (CalcValue *)operand;
- (Function)pendingFunction;
- (CalcValue *)pendingValue;
- (void)setWeek:(Week)week exclude:(BOOL)exclude;
- (BOOL)isAllCleared;
@end
