//
//  CalcController.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/14.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Week.h"

@class CalcValue;
@interface CalcController : NSObject
- (CalcValue *)inputInteger:(NSInteger)integer;
- (CalcValue *)inputDate:(NSDate *)date;
- (CalcValue *)inputNumberString:(NSString *)numberString;
- (void)setWeek:(Week)week exclude:(BOOL)exclude;
@end
