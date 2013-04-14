//
//  DateCalcResult.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/13.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalcValue;

@interface DateCalcResult : NSObject
- (CalcValue *)calcValue;
- (CalcValue *)inputNumberString:(NSString *)numberString;
- (CalcValue *)inputDate:(NSDate *)date;
- (CalcValue *)inputDecimalPoint;
- (CalcValue *)clear;
- (CalcValue *)deleteNumber;
- (CalcValue *)reverseNumber;
@end
