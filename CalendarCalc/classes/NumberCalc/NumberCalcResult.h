//
//  NumberCalcResult.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/11.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalcValue;

@interface NumberCalcResult : NSObject
- (NSDecimalNumber *)decimalNumberValue;
- (CalcValue *)inputNumberString:(NSString *)numberString;
- (CalcValue *)inputDecimalPoint;
- (CalcValue *)clear;
- (CalcValue *)deleteNumber;
- (CalcValue *)reverseNumber;
@end
