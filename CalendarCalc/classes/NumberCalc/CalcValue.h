//
//  CalcValue.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/12.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalcValue : NSObject
+ (CalcValue *)calcValueWithNumberString:(NSString *)number decimalString:(NSString *)decimal;
+ (CalcValue *)calcValueWithDecimalNumber:(NSDecimalNumber *)decimalNumber;
+ (CalcValue *)calcValueWithDate:(NSDate *)date;

- (BOOL)isNumber;
- (NSString *)stringNumberValue;
- (NSString *)stringDateValue;
- (NSDecimalNumber *)decimalNumberValue;
- (NSDate *)dateValue;
@end
