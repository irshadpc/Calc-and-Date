//
//  CCNumberResult.h
//  CalendarCalc
//
//  Created by Ishida Junichi on 2012/12/15.
//  Copyright (c) 2012年 Ishida Junichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalendarCalcResult;

@interface NumberResult : NSObject {
  @private
    NSMutableString *_number;
    NSMutableString *_decimal;
    BOOL _isMinus;
    BOOL _isDecimal;
    BOOL _isClear;
}
+ (NSDecimalNumber *)numberFromString:(NSString *)string;
+ (NSString *)stringFromNumber:(NSDecimalNumber *)number;

- (void)clear;

- (NSDecimalNumber *)result;
- (void)setResult:(NSDecimalNumber *)number;

- (void)clearEntry;
- (void)inputNumber:(NSDecimalNumber *)number;
- (void)inputDecimalPoint;
- (void)reverse;

- (NSString *)displayResult;
@end
