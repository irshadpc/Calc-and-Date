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
- (BOOL)isCleared;
- (NSString *)stringValue;
- (NSDecimalNumber *)decimalNumberValue;
- (NSString *)stringNumberValue;
- (NSString *)stringDecimalValue;
- (NSDate *)dateValue;
- (void)inputNumberString:(NSString *)numberString;
- (void)inputDate:(NSDate *)date;
- (void)inputDecimalPoint;
- (void)clear;
- (void)deleteNumber;
- (void)reverseNumber;
@end
