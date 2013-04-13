//
//  NumberCalcResult.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2013/04/11.
//  Copyright (c) 2013年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Result;

@interface NumberCalcResult : NSObject
- (NSDecimalNumber *)decimalNumberValue;
- (Result *)inputNumberString:(NSString *)numberString;
- (Result *)inputDecimalPoint;
- (Result *)clear;
- (Result *)deleteNumber;
- (Result *)reverseNumber;
@end
